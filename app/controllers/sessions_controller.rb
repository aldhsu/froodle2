class SessionsController < ApplicationController
  def create
    @access_token = params[:auth_token][:access_token]
    response = HTTParty.get("https://www.googleapis.com/plus/v1/people/me?access_token=" + @access_token)
    user_id = response["id"]
    name = response["displayName"]
    session["user_id"] = user_id
    if (user = User.find_by(gpid: user_id)) == nil
      user = User.create(gpid: user_id, name: name)
    end
    user.update(access_token: @access_token)
    session['user_id'] = user.id
    render json: user
  end

  def destroy
    revokeUrl = "https://accounts.google.com/o/oauth2/revoke?token=#{@current_user.access_token}";
    response = HTTParty.get(revokeUrl)
    session[:user_id] = nil
    redirect_to root_path
  end
end
