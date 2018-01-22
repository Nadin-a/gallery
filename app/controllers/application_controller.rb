# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
# protect_from_forgery with: :null_session, if: -> { request.format.json? } # FIXME: DONT NEED DISABLE CSRF

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def set_locale
    locale = params[:lang] || session[:lang] || I18n.default_locale
    I18n.locale = if I18n.locale_available?(locale)
                    session[:lang] = locale if params[:lang].present?
                    locale
                  else
                    I18n.default_locale
                  end
  end

  def after_sign_in_path_for(_)
    request.env['omniauth.origin'] || root_path
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[name email password password_confirmation remember_me]
    upd_attrs = %i[name email avatar password password_confirmation remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: upd_attrs
  end

  def track_action(action_type)
    ahoy.track request.original_url.to_s, params: request.path_parameters, action_type: action_type if user_signed_in?
  end
end
