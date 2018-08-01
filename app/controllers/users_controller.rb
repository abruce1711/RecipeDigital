class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update]

  def show
    @user = current_user
    @recipes = Recipe.where(:user_id => @user.id)
  end

  def edit
    check_user
  end

  def update
    check_user
    @user.update(account_update_params)
    pp @user.errors.full_messages
    redirect_to @user
  end

  private
  def set_user
    @user = User.find_by_slug(params[:id])
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :current_password, :avatar)
  end

  def check_user
    if @user.id != current_user.id
      raise ActionController::RoutingError.new('Not Found')
    end
  end

end
