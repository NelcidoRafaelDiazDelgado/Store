Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :openid_connect,
    name: :openid_connect,
    scope: [ :openid, :profile, :email ],
    response_type: :code,

    issuer: "http://keycloak:8080/realms/rails-dev",

    discovery: true,

    client_auth_method: "query",

    client_options: {
      identifier: "rails-app",
      secret: "YOUR_CLIENT_SECRET",
      redirect_uri: "http://localhost:3000/auth/openid_connect/callback"
    }
  )
end
