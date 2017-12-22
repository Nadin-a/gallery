class SendEmailWhenNewImageJob < ApplicationJob
  def perform(user_id, image_id)
    UserMailer.new_image_email(user_id, image_id).deliver_later
  end
end
