if Rails.env.development?
    SWD.url_builder = URI::HTTP
    WebFinger.url_builder = URI::HTTP # Good to have if you use WebFinger discovery
end



Rails.application.config.middleware.use OmniAuth::Builder do
  provider :openid_connect,
    name: :keycloak,
    scope: [ :openid, :email, :profile ],
    response_type: :code,
    issuer: "http://keycloak:8080/realms/rails-dev",
    discovery: true,
    client_options: {
      identifier: ENV["KEYCLOAK_CLIENT_ID"],
      secret: ENV["KEYCLOAK_CLIENT_SECRET"],
      redirect_uri: ENV["KEYCLOAK_REDIRECT_URI"],
      # Explicitly set endpoints to work in Docker
      authorization_endpoint: "http://localhost:8080/realms/rails-dev/protocol/openid-connect/auth",
      token_endpoint: "http://localhost:8080/realms/rails-dev/protocol/openid-connect/token",
      userinfo_endpoint: "http://localhost:8080/realms/rails-dev/protocol/openid-connect/userinfo"
    }
end
