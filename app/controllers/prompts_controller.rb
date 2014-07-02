class PromptsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @prompt = Prompt.new
  end

  def create
    @params = Prompt.create(prompt_params)
    redirect_to new_prompt_path
  end

  def delete
  end

  private
  def prompt_params
    params.require(:prompt).permit(:question, :difficulty)
  end
end
