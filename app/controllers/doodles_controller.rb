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
    prompt = Prompt.find_by(question: params[:question])
    @doodle = Doodle.create(image: params[:image].tempfile, prompt_id: prompt.id )
    @current_user.doodles << @doodle
    @current_user.points += prompt.difficulty
    @current_user.save
    render nothing: true
  end

  def new
    @prompt = (Prompt.all - @current_user.doodles.map{|doodle| doodle.prompt}).shuffle.first
    @doodle = Doodle.new
  end

  def destroy
  end

  def guess
    #catch error if none left
    begin
      #get all doodles, subtract where ratings exist
      @doodle = (Doodle.all - @current_user.ratings.map{|rating| rating.doodle}).shuffle.first
      @prompts = [@doodle.prompt.question] + (Prompt.all-[@doodle.prompt]).shuffle[1,3].map{|prompt| prompt.question}
      # raise
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
      @current_user.save
      @display = "Correct! +#{@doodle.prompt.difficulty}pts Total: #{@current_user.points}"
      Rating.create(user_id: @current_user.id, doodle_id: @doodle.id, guessed: 1)
    else
      @display = "Incorrect! Prompt was #{@solution}!"
      Rating.create(user_id: @current_user.id, doodle_id: @doodle.id, guessed: -1)
    end
  end
end
