class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  include SessionsHelper

  def hello
    render html: "hello, word!"
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "micropost.require"
    redirect_to login_url
  end
end
