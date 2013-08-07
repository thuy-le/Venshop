class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user, only: [:edit, :update]
  def edit
    #raise NotAuthorizedError unless signed_in?
    @user = User.find(params[:id])
  end
  def update
    user_params = params[:user]
    @user = User.find(user_params[:id])
    if @user.update_attributes(user_params)
    # Handle a successful update.
      sign_in @user
      redirect_to ('/user/' + @user.id.to_s)
    else
      Rails.logger.info(@user.errors.messages.inspect)
      render 'edit'
    end
  end
  def new
    @user = User.new
  end
  def show
    @user = User.find(params[:id])
  end
  def index
    @users = User.all
  end
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to ('/user/' + @user.id.to_s)
    else
      render 'new'
    end
  end

private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  def signed_in_user
    redirect_to signin_url, notice: "Please sign in." unless signed_in?
  end
  def correct_user
    @user = User.find(params[:id])
    if(!current_user?(@user))
      redirect_to(root_url)
      flash[:error] = "You need to be authorized to access that content"
    end
  end
end
