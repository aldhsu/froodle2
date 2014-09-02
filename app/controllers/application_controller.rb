class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :get_user

  def get_user
    # binding.pry
    if session['user_id'].present?
      @current_user = User.where(id: session['user_id']).first
      session['user_id'] = nil if !@current_user
    else
      # redirect_to root_path
    end
  end

end
