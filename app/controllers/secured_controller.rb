class SecuredController < ApplicationContoller
  include Authenticated

  def index
    render json: { message: "Area segura", user: current_user.email }
  end
end
