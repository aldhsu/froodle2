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
    @access_token = params[:auth_token][:access_token]
    response = HTTParty.get("https://www.googleapis.com/plus/v1/people/me?access_token=" + @access_token)
    user_id = response["id"]
    name = response["displayName"]
    session["user_id"] = user_id
    if User.find_by(gpid: user_id) == nil
      User.create(gpid: user_id, name: name)
    end
    render nothing: true
  end

  def destroy
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:name)
  end

end
