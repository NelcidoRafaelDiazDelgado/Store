ENV["RAILS_ENV"] ||= "test"

# ========== KEYCLOAK ENV VARIABLES PARA TEST ==========
ENV["KEYCLOAK_REALM"] ||= "rails-dev"
ENV["KEYCLOAK_SITE"] ||= "http://keycloak:8080"
ENV["KEYCLOAK_CLIENT_ID"] ||= "rails-app"
ENV["KEYCLOAK_CLIENT_SECRET"] ||= "test-client-secret" # Aqui no se debe mostrar la clave secrete actual de cliente
ENV["KEYCLOAK_REDIRECT_URI"] ||= "http://localhost:3000/auth/openid_connect/callback"
ENV["KEYCLOAK_ISSUER"] ||= "http://keycloak:8080/realms/rails-dev"

require_relative "../config/environment"
require "rails/test_help"
require "webmock/minitest"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

module KeycloakTestHelper
  def stub_jwks_response
    jwks_keys = {
      "keys" => [ {
        "kty" => "RSA",
        "kid" => "test-key",
        "use" => "sig",
        "n" => "test_modulus",
        "e" => "AQAB"
      } ]
    }

    stub_request(:get, %r{/realms/.*/protocol/openid-connect/certs})
      .to_return(body: jwks_keys.to_json)
  end

  def stub_token_exchange(code, access_token)
    stub_request(:post, %r{/realms/.*/protocol/openid-connect/token})
      .with(body: hash_including(code: code))
      .to_return(
        body: {
          access_token: access_token,
          id_token: "test_id_token",
          token_type: "Bearer"
        }.to_json
      )
  end
end

class ActiveSupport::TestCase
  include KeycloakTestHelper
end
