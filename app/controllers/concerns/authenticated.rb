module Authenticated
  extend ActiveSupport::Concern

  included do
    before_action :require_login
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = session[:user_id] ? Authentication::User.find(session[:user_id]) : nil
  end


  def user_signed_in?
    current_user.present?
  end

  def require_login
    unless user_signed_in?
      session[:return_to] = request.fullpath
      redirect_to "/login", alert: "Debes iniciar sesion lol"
    end
  end

  def require_role(role)
    roles = session[:user_roles] || []
    return if roles.include?(role)
    render json: { error: "Acceso denegado" }, status: :forbidden
  end
end
