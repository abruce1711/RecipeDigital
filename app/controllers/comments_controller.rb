class CommentsController < ApplicationController

  before_action :authenticate_user!, only: :create

  def create
    @comment = Comment.new(comment_params)
    @recipe = Recipe.find(params[:comment][:recipe_id])
    @comment.user_id = current_user.id
    @comment.save
    redirect_to @recipe
  end

  def destroy
    @comment = Comment.find(params[:id])
    @recipe = Recipe.find(@comment.recipe_id)

    if @comment.user_id == current_user.id
      @comment.destroy
      redirect_to @recipe
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:title, :body, :rating, :recipe_id, :user_id)
  end

  def check_comment_owner
    if @recipe.user_id != current_user.id
      raise ActionController::RoutingError.new('Not Found')
    end
  end

end
