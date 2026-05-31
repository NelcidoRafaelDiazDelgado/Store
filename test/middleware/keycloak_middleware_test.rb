# test/middleware/keycloak_middleware_test.rb
require "test_helper"
require "jwt"

class KeycloakMiddlewareTest < ActiveSupport::TestCase
  # Generar clave RSA compartida para TODOS los tests
  @@private_key = OpenSSL::PKey::RSA.new(2048)
  @@public_key = @@private_key.public_key

  setup do
    # STUB PRIMERO, antes de crear el middleware
    stub_jwks_with_key

    @app = lambda { |env| [ 200, {}, [ "OK" ] ] }
    @middleware = Keycloak::Middleware.new(@app)
  end

  # ========== TESTS DE RUTAS PÚBLICAS ==========

  test "debe permitir acceso a rutas públicas sin token" do
    env = Rack::MockRequest.env_for("/")
    status, _, body = @middleware.call(env)

    assert_equal 200, status
  end

  test "debe permitir acceso a /login sin token" do
    env = Rack::MockRequest.env_for("/login")
    status, _, body = @middleware.call(env)

    assert_equal 200, status
  end

  test "debe permitir acceso a /auth/* sin validación" do
    env = Rack::MockRequest.env_for("/auth/anything")
    status, _, body = @middleware.call(env)

    assert_equal 200, status
  end

  # ========== TESTS DE EXTRACCIÓN DE TOKEN ==========

  test "debe extraer token del header Authorization" do
    valid_token = create_test_jwt
    env = Rack::MockRequest.env_for("/secured")
    env["HTTP_AUTHORIZATION"] = "Bearer #{valid_token}"

    token = @middleware.send(:extract_token, Rack::Request.new(env))
    assert_equal valid_token, token
  end

  test "debe extraer token de la sesión" do
    valid_token = create_test_jwt
    env = Rack::MockRequest.env_for("/secured")
    env["rack.session"] = { access_token: valid_token }

    token = @middleware.send(:extract_token, Rack::Request.new(env))
    assert_equal valid_token, token
  end

  test "debe retornar nil sin token" do
    env = Rack::MockRequest.env_for("/secured")
    token = @middleware.send(:extract_token, Rack::Request.new(env))
    assert_nil token
  end

  # ========== TESTS DE RUTAS PROTEGIDAS ==========

  test "debe redirigir a login si no hay token en ruta protegida" do
    env = Rack::MockRequest.env_for("/secured")
    status, headers, _ = @middleware.call(env)

    assert_equal 302, status
    assert_equal "/login", headers["Location"]
  end

  test "debe rechazar token inválido" do
    env = Rack::MockRequest.env_for("/secured")
    env["HTTP_AUTHORIZATION"] = "Bearer invalid_token"
    status, _, body = @middleware.call(env)

    assert_equal 401, status
  end

  # ========== TESTS DE VALIDACIÓN DE ROLES ==========

  test "debe permitir acceso a /secured con rol 'user'" do
    valid_token = create_test_jwt(roles: [ "user" ])
    env = Rack::MockRequest.env_for("/secured")
    env["HTTP_AUTHORIZATION"] = "Bearer #{valid_token}"

    status, _, _ = @middleware.call(env)
    assert_equal 200, status
  end

  test "debe denegar acceso a /secured sin rol 'user'" do
    valid_token = create_test_jwt(roles: [ "viewer" ])
    env = Rack::MockRequest.env_for("/secured")
    env["HTTP_AUTHORIZATION"] = "Bearer #{valid_token}"

    status, _, body = @middleware.call(env)
    assert_equal 403, status
    assert_includes body.first, "Insufficient role"
  end

  test "debe permitir acceso a /admin con rol 'admin'" do
    valid_token = create_test_jwt(roles: [ "admin" ])
    env = Rack::MockRequest.env_for("/admin")
    env["HTTP_AUTHORIZATION"] = "Bearer #{valid_token}"

    status, _, _ = @middleware.call(env)
    assert_equal 200, status
  end

  test "debe denegar acceso a /admin sin rol 'admin'" do
    valid_token = create_test_jwt(roles: [ "user" ])
    env = Rack::MockRequest.env_for("/admin")
    env["HTTP_AUTHORIZATION"] = "Bearer #{valid_token}"

    status, _, body = @middleware.call(env)
    assert_equal 403, status
  end

  # ========== TESTS DEL CALLBACK ==========

  test "debe manejar callback sin código de autorización" do
    env = Rack::MockRequest.env_for("/auth/openid_connect/callback")
    status, _, body = @middleware.call(env)

    assert_equal 401, status
  end

  # ========== TESTS HELPER ==========

  private

  def create_test_jwt(roles: [], sub: "test-user", name: "Test User", email: "test@example.com")
    payload = {
      sub: sub,
      name: name,
      email: email,
      realm_access: { roles: roles }
    }

    JWT.encode(payload, @@private_key, "RS256")
  end

  def stub_jwks_with_key
    # Exportar la clave pública como JWKS
    jwk = JWT::JWK.new(@@private_key)
    jwks_response = {
      "keys" => [ jwk.export(public_key: true) ]
    }

    stub_request(:get, /protocol\/openid-connect\/certs/)
      .to_return(
        status: 200,
        body: jwks_response.to_json,
        headers: { "Content-Type" => "application/json" }
      )
  end
end
