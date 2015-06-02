class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(params[:login][:email])

    if user && user.authenticate(params[:login][:password])
      session[:user_id] = user.id.to_s
    else
      flash.now[:error] = "Your email address or password is incorrect."
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path
  end
end
