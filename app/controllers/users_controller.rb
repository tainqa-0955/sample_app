class UsersController < ApplicationController
  before_action :load_user, except: %i(index new create)
  before_action :logged_in_user, except: %i(new show create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.activate.paginate page: params[:page],
      per_page: Settings.paginate[:per_page]
  end

  def new
    @user = User.new
  end

  def show
    @microposts = @user.microposts.paginate page: params[:page],
      per_page: Settings.paginate[:per_page]
    redirect_to root_url && return unless @user.activated
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "static_pages.user.signup.check_mail"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "users.edit.update_success"
      redirect_to @user
    else
      flash.now[:danger] = t "users.edit.update_failed"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "users.edit.deleted"
    else
      flash[:danger] = t "users.edit.deleted_fail"
    end
    redirect_to users_url
  end

  def following
    @title = t "follow.following"
    @users = @user.following.paginate page: params[:page]
    render "show_follow"
  end

  def followers
    @title = t "follow.follower"
    @users = @user.followers.paginate page: params[:page]
    render "show_follow"
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation
  end

  def correct_user
    redirect_to root_url unless @user == current_user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "static_pages.user.signup.not_found_relationship"
    redirect_to root_url
  end
end
