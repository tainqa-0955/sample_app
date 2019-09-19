class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find_by_id params[:id]
    return if @user
    flash[:danger] = t "static_pages.user.signup.not_found_user"
    redirect_to signup_path
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "static_pages.user.signup.message_success"
      redirect_to @user
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
