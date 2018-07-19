class RecipesController < ApplicationController

  before_action :set_recipe, only: [:show, :destroy, :edit, :update]

  def index
    @recipes = Recipe.all
  end

  def show
    @ingredient = Ingredient.new
    @step = Step.new
    @ingredients = Ingredient.all
    @ingredients.each do |ingredient|
      ingredient = ingredient.amount.to_i if ingredient.amount == ingredient.amount.to_i
    end
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe
    else
      render :new
    end
  end

  def edit
  end

  def update
    @recipe.update(recipe_params)
    redirect_to @recipe
  end

  def destroy
    @recipe.destroy
    @recipe.ingredients.destroy_all
    @recipe.steps.destroy_all
    redirect_to '/'
  end

  private
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description, :cover)
  end
end
