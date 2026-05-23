require Rails.root.join("app/middleware/keycloak/middleware")

Rails.application.config.middleware.use Keycloak::Middleware
