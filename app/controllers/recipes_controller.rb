class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_recipe, only: [:show, :destroy, :edit, :update]

  def index
    @recipes = Recipe.where(:published => true)
  end

  def my_recipes
    @recipes = Recipe.where(:user_id => current_user.id)
  end

  def show
    @ingredient = Ingredient.new
    @step = Step.new
    @user = User.find(@recipe.user_id)
    @comment = Comment.new
    @average = @recipe.average_rating
  end

  def new
    @recipe = Recipe.new
  end

  def publish_recipe
    recipe = Recipe.find_by_slug(params[:slug])
    if recipe.publish_recipe
      flash[:notice] = "Recipe published. This means any user can see it."
      redirect_to recipe
    else
      flash[:alert] = "You must have ingredients and steps to publish recipe"
      redirect_to recipe
    end
  end

  def unpublish_recipe
    recipe = Recipe.find_by_slug(params[:slug])
    recipe.update_attributes(:published => false)
    flash[:notice] = "Recipe unpublished. Only you can see this now."
    redirect_to recipe
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    @tags = params[:tags]
    @recipe.add_tags(@tags)
    puts @tags
    if @recipe.save
      redirect_to @recipe
    else
      render :new
    end
  end

  def edit
    check_recipe_owner
  end

  def update
    check_recipe_owner
    @tags = params[:tags]
    tag_bool = true
    if @recipe.tags.length > 0
      if !@recipe.update_tags(@tags)
        tag_bool = false
      end
    else
      @recipe.add_tags(@tags)
    end
    if tag_bool
      @recipe.update(recipe_params)
      redirect_to @recipe
    else
      @recipe.errors[:base] << "Please add at least 1 tag"
      render :edit
    end
  end

  def destroy
    check_recipe_owner
    @recipe.destroy_recipe
    redirect_to '/my_recipes'
  end

  private
  def set_recipe
    @recipe = Recipe.find_by_slug(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description, :cover, :user_id)
  end

  def check_recipe_owner
    if @recipe.user_id != current_user.id
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
