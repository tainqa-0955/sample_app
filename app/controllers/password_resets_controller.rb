class PasswordResetsController < ApplicationController
  before_action :load_user, only: [:create, :edit, :update]
  before_action :valid_user, :check_expiration,
                only: [:edit, :update]

  def new; end

  def create
    @user.create_reset_digest
    @user.send_password_reset_email
    flash[:info] = t "users.forgot_password.send_email"
    redirect_to root_url
  end

  def edit; end

  def update
    if params[:user][:password].blank?
      @user.errors.add :password, t("users.reset_password.empty_password")
      render :edit
    elsif @user.update user_params
      log_in @user
      @user.update reset_digest: nil
      flash[:success] = t "users.reset_password.success"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def load_user
    @user = if params[:email]
              User.find_by email: params[:email]
            else
              User.find_by email: params[:password_reset][:email].downcase
            end
    return if @user

    flash.now[:danger] = t "users.forgot_password.email_not_found"
    render :new
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def valid_user
    return if @user.activated? && @user.authenticated?(:reset, params[:id])

    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t "users.reset_password.expired"
    redirect_to new_password_reset_url
  end
end
