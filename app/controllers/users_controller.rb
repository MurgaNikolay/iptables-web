class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: {user: current_user}
  end
end
