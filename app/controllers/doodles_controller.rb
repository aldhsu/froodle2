class DoodlesController < ApplicationController

  def index
    @doodles = Doodle.all
  end

  def show
  end

  def create
    @current_user = User.find(session["user_id"])
    prompt = Prompt.find_by(question: params[:question])
    @doodle = Doodle.create(image: params[:image].tempfile, prompt_id: prompt.id )
    @current_user.doodles << @doodle
    @current_user.points += prompt.difficulty
    @current_user.save
    render nothing: true
  end

  def new
    # Need to see if random is too slow
    @prompt = Doodle.get_prompt(@current_user)
    @doodle = Doodle.new
  end

  def destroy
  end

  def guess
    #catch error if none left
    begin
      #get all doodles, subtract where ratings exist
      #need to refine this again with joins (Doodle.joins(:rating).where.not('ratings.user_id' => @current_user ), random on count?)
      @doodle = (Doodle.where.not(user_id: @current_user.id) - @current_user.ratings.map{|rating| rating.doodle}).shuffle.first
      # Get the prompts not including the one that has already been chosen probably dont shuffle the whole thing just get a few entries and randomise
      # Again need to refine this
      @prompts = (Prompt.where.not(id: @doodle.prompt.id).pluck(:question).shuffle[1,3] + [@doodle.prompt.question]).shuffle
      # raise
    rescue
      @error = "No Doodles left to guess."
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
      @doodle.user.points += @doodle.prompt.difficulty
      @doodle.save
    else
      @display = "Incorrect! Prompt was #{@solution}!"
      Rating.create(user_id: @current_user.id, doodle_id: @doodle.id, guessed: -1)
    end
  end
end
