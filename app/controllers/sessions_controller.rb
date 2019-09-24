class SessionsController < ApplicationController
  before_action :load_user, only: :create

  def new; end

  def create
    if @user.activated?
      log_in @user
      flash[:success] = t "static_pages.user.login.success_messages"
      if params[:session][:remember_me] == Settings.session[:remember_true]
        remember @user
      else
        forget @user
      end
      redirect_back_or @user
    else
      flash[:warning] = t "user_mailer.account_activation.not_active"
      redirect_to root_url
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private

  def load_user
    @user = User.find_by email: params[:session][:email].downcase
    return if @user&.authenticate(params[:session][:password])

    flash[:danger] = t "static_pages.user.login.error_messages"
    redirect_to login_path
  end
end
