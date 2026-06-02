require Rails.root.join("app/middleware/keycloak/middleware")

required_env_vars = %w[
  KEYCLOAK_REALM
  KEYCLOAK_SITE
  KEYCLOAK_CLIENT_ID
  KEYCLOAK_CLIENT_SECRET
  KEYCLOAK_REDIRECT_URI
]

if required_env_vars.all? { |key| ENV[key].present? }
  Rails.application.config.middleware.use Keycloak::Middleware
else
  Rails.logger.warn("Keycloak middleware disabled: missing required KEYCLOAK_* environment variables")
end
