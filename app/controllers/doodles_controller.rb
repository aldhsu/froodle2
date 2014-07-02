class DoodlesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @doodles = Doodle.all
  end

  def show
  end

  def create
    binding.pry
    @current_user = User.find_by(gpid: session["user_id"])
    @doodle = Doodle.create(image: params[:image].tempfile, prompt_id: Prompt.find_by(question: params[:question]).id)
    @current_user.doodles << @doodle
    render nothing: true
  end

  def new
    @prompt = Prompt.all.shuffle.first.question
    @doodle = Doodle.new
  end

  def destroy
  end

  def guess
    @doodle = Doodle.all.shuffle.first
    @prompts = [@doodle.prompt.question] + Prompt.all.shuffle[1,3].map{|prompt| prompt.question}
  end

  def check
  end
end
