class ApplicationController < ActionController::Base

  before_action :set_i18n_locale_from_params
  before_action :start_timer
  before_action :authorize, :hit_counter, :check_session_timout, :refresh_session_time
  around_action :set_i18n_language
  after_action :response_time
  after_action :end_timer

  protected
  def authorize
    unless User.find_by(id: session[:user_id])
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

  def set_i18n_language(&action)
    if current_user
      language = LANGUAGES.to_h[current_user.language]
      I18n.with_locale(language,&action)
    else
      yield
    end
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def redirect_to_login
    redirect_to login_url
  end

  def hit_counter
    session[:counter] ||= Hash.new
    controller = params[:controller]
    action = params[:action]

    if session[:counter]["#{controller}##{action}"]
      session[:counter]["#{controller}##{action}"] += 1
    else
      session[:counter]["#{controller}##{action}"] = 1
    end
    @hit_counter = session[:counter]["#{controller}##{action}"]
  end

  private

  def start_timer
    response.header['start_time'] = Time.current
  end

  def end_timer
    response.header['end_time'] = Time.current
  end

  def response_time
    response.header['x-responded-in'] = (response.header['end_time'] - response.header['start_time'])*1000
  end

  def check_session_timout
    session[:timeout] ||= Time.current + 5.minute
    redirect_to sessions_destroy_path if session[:timeout] < Time.current
  end

  def refresh_session_time
    session[:timeout] = Time.current + 5.minute
  end

end
