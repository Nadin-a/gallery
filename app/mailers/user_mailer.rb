# frozen_string_literal: true

class MyMailer < ActionMailer::Base
  include Resque::Mailer
  default from: 'notifications@example.com'

  def subscribe_to_category
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email,
         subject: 'Subscribtion to category') do |format|
      format.html { render 'mailer/subscribe_mail' }
      format.text { render plain: 'Render text' }
    end
  end
end