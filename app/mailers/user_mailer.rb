# frozen_string_literal: true

class UserMailer < ActionMailer::Base

  def subscribe_email(user_id)
    @user = User.find(user_id)
    mail(to: @user.email,
         subject: 'Subscribtion to new category!') do |format|
      format.html { render 'user_mailer/subscribe_mail' }
      format.text { render plain: 'Render text' }
    end
  end

  def new_image_email(user_id, image_id)
    @user = User.find(user_id)
    @image = Image.find(image_id)
    mail(to: @user.email,
         subject: 'New image in favorite category!') do |format|
      format.html { render 'user_mailer/new_image_mail' }
      format.text { render plain: 'Render text' }
    end
  end

end


