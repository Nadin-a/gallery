# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :track_action
  protect_from_forgery with: :null_session, if: ->{request.format.json?}

  protected

  def configure_permitted_parameters
    added_attrs = %i[name email password password_confirmation remember_me]
    upd_attrs = %i[name email avatar password password_confirmation remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: upd_attrs
  end

  def track_action
    action_type =
      case "#{controller_path}##{action_name}"
      when 'comments#create'
        'comment'
      when 'likes#create'
        'like'
      when 'likes#destroy'
        'unlike'
      when 'devise/sessions#create'
        'user sign in'
      else
        'navigation'
      end
    ahoy.track "#{request.original_url}", params: request.path_parameters, action_type: action_type if user_signed_in?
  end
end
