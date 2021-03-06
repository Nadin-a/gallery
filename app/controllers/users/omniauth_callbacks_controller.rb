# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    authentication_user
  end

  def twitter
    authentication_user
  end

  def google_oauth2
    authentication_user
  end

  def failure
    redirect_to root_path
  end

  private

  def authentication_user
    @user = User.create_with_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to root_path, flash: { error: t('error') }
    end
  end
end
