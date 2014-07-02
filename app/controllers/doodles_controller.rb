class DoodlesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @doodles = Doodle.all
  end

  def show
  end

  def create
    @current_user = User.find_by(gpid: session["user_id"])
    @doodle = Doodle.create(image: params[:image].tempfile)
    @current_user.doodles << @doodle
    render nothing: true
  end

  def new
    @doodle = Doodle.new
  end

  def destroy
  end
end
