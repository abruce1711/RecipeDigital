class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show]

  def show
    @recipes = Recipe.where(:user_id => @user.id)
  end

  def edit
    check_user
  end

  def update
    check_user
    @user.update(account_update_params)
    if @user.errors.full_messages.length > 0
      flash[:alert] = "#{@user.errors.full_messages}"
      redirect_to :back
    elsif @user.previous_changes["unconfirmed_email"]
      sign_out @user
      flash[:notice] = "Confirmation email sent to #{@user.previous_changes['unconfirmed_email'][1]}. Click link in email to complete change"
      redirect_to '/'
    else
      flash[:notice] = "#{@user.previous_changes().first[0].split('_').map(&:capitalize).join(' ')} updated"
      redirect_to @user
    end
  end

  private
  def set_user
    @user = User.find_by_slug(params[:id])
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :current_password, :avatar, :bio)
  end

  def check_user
    if user_signed_in?
      if @user.id != current_user.id
        raise ActionController::RoutingError.new('Not Found')
      end
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

end
