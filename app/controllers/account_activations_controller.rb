class AccountActivationsController < ApplicationController
  before_action :load_user, only: :edit

  def edit
    if !@user.activated? && @user.authenticated?(:activation, params[:id])
      user.activate
      log_in @user
      flash[:success] = t "user_mailer.account_activation.success"
      redirect_to @user
    else
      flash[:danger] = t "user_mailer.account_activation.failed"
      redirect_to root_url
    end
  end

  private

  def load_user
    @user = User.find_by email: params[:email]
    return if @user

    flash[:danger] = t "user.signup.not_found_user"
    redirect_to root_url
  end
end
