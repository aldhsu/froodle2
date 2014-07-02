class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :get_user

  def get_user
    if session['user_id'].present?
      @current_user = User.find_by(gpid: session['user_id'])
    end
  end

end
