# frozen_string_literal: true

class UserMailer < ActionMailer::Base
  include Sidekiq::Mailer
  def subscribe_email(user)
    @user = User.find(user_id)
    p'!!!!!!!!!!!!!!!MAILER!!1'
    mail(to: @user.email,
         subject: 'Subscribtion to category') do |format|
      format.html { render 'user_mailer/subscribe_mail' }
      format.text { render plain: 'Render text' }
    end
  end
end


