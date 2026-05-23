Rails.application.routes.draw do
  root "home#index"

  # Keycloak callback (handled by middleware, but route needed for Rails)
  get "/auth/openid_connect/callback", to: "home#index"
  
  # Logout
  delete "/logout", to: "sessions#destroy", as: :logout
end
