class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @users = User.all
  end

  def show
  end

  def new
  end

  def create
  end

  def destroy
    session["user_id"] = nil
    redirect_to root_path
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to users_details_path
  end

  def details
  end

  private
  def user_params
    params.require(:user).permit(:name)
  end

end
