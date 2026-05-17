class AdminController < ApplicationController
  include Authenticated

  before_action { require_role("admin") }

  def index
    render json: { message: "Area administrativa" }
  end
end
