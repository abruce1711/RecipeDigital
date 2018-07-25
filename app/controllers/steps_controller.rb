class StepsController < ApplicationController

  before_action :set_step, only: [:destroy, :update]

  def create
    @recipe = Recipe.find(params[:step][:recipe_id])
    @step = Step.new(step_params)
    @ingredient = Ingredient.new
    if @step.save
      redirect_to recipe_path(@recipe, :anchor => 'steps')
    else
      flash[:error] = "Error in ingredients form"
      redirect_to recipe_path(@recipe, :anchor => 'ingredients')
    end
  end

  def destroy
    @step.destroy
    redirect_to recipe_path(@recipe, :anchor => 'steps')
  end

  def update
    if @step.update(step_params)
      redirect_to recipe_path(@recipe, :anchor => 'steps')
    else
      flash[:error] = "Error in ingredients form"
      redirect_to recipe_path(@recipe, :anchor => 'ingredients')
    end
  end

  private
  def step_params
    params.require(:step).permit(:content, :recipe_id)
  end

  def set_step
    @step = Step.find(params[:id])
    @recipe = Recipe.find(@step.recipe_id)
  end

end
