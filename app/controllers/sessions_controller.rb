class SessionsController < ApplicationController
  before_action :logged_in_redieect, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in"
      redirect_to root_path
    else
      flash.now[:error] = "There was something wrong with your credentials"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out"
    redirect_to login_path

  end


  private

  def logged_in_redieect
    if logged_in?
        flash[:error] = "You area already logged in"
        redirect_to root_path
    end
  end

end
