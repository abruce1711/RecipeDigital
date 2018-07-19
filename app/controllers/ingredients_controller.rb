class IngredientsController < ApplicationController

  before_action :set_ingredient, only: [:destroy, :update]

  def index
    redirect_to '/'
  end

  def create
    @recipe = Recipe.find(params[:ingredient][:recipe_id])
    @ingredient = Ingredient.new(ingredient_params)
    @step = Step.new
    if @ingredient.save
      redirect_to recipe_path(@recipe, :anchor => 'ingredients')
    else
      render 'recipes/show'
    end
  end

  def destroy
    @ingredient.destroy
    redirect_to recipe_path(@recipe, :anchor => 'ingredients')
  end

  def update
    @step = Step.new
    if @ingredient.update(ingredient_params)
      redirect_to recipe_path(@recipe, :anchor => 'ingredients')
    else
      render 'recipes/show'
    end
  end

  private
  def ingredient_params
    params.require(:ingredient).permit(:measurement, :item, :amount, :recipe_id)
  end

  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
    @recipe = Recipe.find(@ingredient.recipe_id)
  end
end
