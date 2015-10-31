class SessionsController < ApplicationController
  before_filter :direct_to_home, only:[:new]

  def new
  end
  
  def create
    if auth_hash
      @user = User.find_or_create_from_auth(auth_hash)
      session[:user_id] = @user.id
      if @user.contents.length > 0
        redirect_to root_url, :notice => "Logged in!"
      else
        redirect_to onboard_url
      end
    else
      user = User.find_by_email(params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to root_url, :notice => "Logged in!"
      else
        flash.now.alert = "Invalid email or password."
        render "new"
      end
    end
  end

  def auth_hash
    request.env['omniauth.auth']
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
