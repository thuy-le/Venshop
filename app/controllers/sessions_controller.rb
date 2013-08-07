class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in(user)
      flash[:notice] = "Welcome, " + user.name
      redirect_to root_path
    else
      flash[:error] = "Wrong username or password"
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  def index
    render 'new'
  end
end
