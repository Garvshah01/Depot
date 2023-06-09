class ApplicationController < ActionController::Base

  before_action :set_i18n_locale_from_params

  before_action :authorize

  protected
  def authorize
    unless current_user
      redirect_to login_url, notice: "Please log in"
    end
  end

  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:notice] =
        "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  def current_user
    @current_user ||= User.find_by(session[:user_id])
  end
end
