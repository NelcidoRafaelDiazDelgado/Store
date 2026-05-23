class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    # puts auth.to_hash

    if auth.nil? || auth.info.nil?
      redirect_to root_path, alert: "Authentication failed. Please try again."
      return
    end

    # Store user information in the session
    session[:user_info] = {
      uid:      auth.uid,
      provider: auth.provider,
      name:     auth.info.name,
      email:    auth.info.email
    }

    # Store id_token in the session for logout
    session[:id_token] = auth.dig("extra", "id_token")

    redirect_to root_path, notice: "Signed in as #{session[:user_info][:name]}"
  end

  def destroy
    id_token = session[:id_token]
    reset_session

    logout_url = "#{keycloak_base_url}/realms/#{keycloak_realm}/protocol/openid-connect/logout" \
                 "?post_logout_redirect_uri=#{CGI.escape(root_url)}&" \
    "id_token_hint=#{id_token}"

    redirect_to logout_url, allow_other_host: true, notice: "Signed out!"
  end

  private

  def keycloak_base_url
    "http://localhost:8080"
  end

  def keycloak_realm
    Rails.application.credentials.dig(:keycloak, :realm) || ENV["KEYCLOAK_REALM"] || "rails-dev"
  end
end
