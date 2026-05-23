class ApplicationController < ActionController::Base
  helper_method :current_user

  private

  def current_user
    info = session[:user_info]
    info.present? ? info.with_indifferent_access : nil
  end
end
