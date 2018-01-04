# # frozen_string_literal: true
#
# class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
#
#   def github
#     @user = User.from_omniauth(request.env["omniauth.auth"])
#     sign_in_and_redirect @user
#   end
#
#   def failure
#     p '========================================'
#     p 'ERROR'
#     redirect_to root_path
#   end
# end
