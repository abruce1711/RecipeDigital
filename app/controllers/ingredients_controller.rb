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
      # load view with js
    else
      flash[:alert] = "Error in ingredients form"
      redirect_to recipe_path(@recipe, :anchor => 'ingredients')
    end
  end

  def destroy
    check_recipe_owner
    @ingredient.destroy
  end

  def update
    check_recipe_owner
    @step = Step.new
    if @ingredient.update(ingredient_params)
      # update with js
    else
      flash[:alert] = "Error in ingredients form"
      redirect_to recipe_path(@recipe, :anchor => 'ingredients')
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

  def check_recipe_owner
    if @recipe.user_id != current_user.id
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
