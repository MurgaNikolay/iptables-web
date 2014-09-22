class SessionsController < ApplicationController
  skip_before_filter :check_authentication
  skip_before_action :verify_authenticity_token
  layout false
  def login

  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    @user = user
    # redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    # redirect_to root_path
    head :no_content
  end
end