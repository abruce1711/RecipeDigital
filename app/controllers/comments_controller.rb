class CommentsController < ApplicationController

  before_action :authenticate_user!, only: :create

  def create
    @comment = Comment.new(comment_params)
    @recipe = Recipe.find(params[:comment][:recipe_id])
    @comment.user_id = current_user.id
    @comment.save
    redirect_to @recipe
  end

  private
  def comment_params
    params.require(:comment).permit(:title, :body, :rating, :recipe_id, :user_id)
  end

end
