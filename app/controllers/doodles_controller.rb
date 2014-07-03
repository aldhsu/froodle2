class DoodlesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @doodles = Doodle.all
  end

  def show
  end

  def create
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
    begin
      @doodle = Doodle.all.shuffle.first
      @prompts = [@doodle.prompt.question] + Prompt.all.shuffle[1,3].map{|prompt| prompt.question}
    rescue
      @prompt = "No Doodles left to guess"
    end
  end

  def check
    @doodle = Doodle.find(params[:id])
    @answer = params[:question]
    @solution = @doodle.prompt.question

    @display = ""
    #logic for checking and setting points
    if @answer == @solution
      @current_user.points += @doodle.prompt.difficulty
      @display = "Correct! +#{@doodle.prompt.difficulty}pts Total: #{@current_user.points}"
      Rating.create(user_id: @current_user.id, doodle_id: @doodle.id, guessed: 1)
    else
      @display = "Incorrect! Prompt was #{@solution}!"
      Rating.create(user_id: @current_user.id, doodle_id: @doodle.id, guessed: -1)
    end
  end
end
