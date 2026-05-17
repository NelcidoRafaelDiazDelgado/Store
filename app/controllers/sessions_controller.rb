class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = Authentication::User.find_or_create_from_keycloak(auth)

    session[:user_id] = user.id
    session[:access_token] = auth.credentials.token
    session[:user_roles] = extract_roles(auth)

    redirect_to session[:return_to] || root_path, notice: "Sesion iniciada"
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "Sesion iniciada"
  end

  private

  def extract_roles(auth)
    auth.dig(:extra, :raw_info, :realm_access, :roles) || []
  end
end
