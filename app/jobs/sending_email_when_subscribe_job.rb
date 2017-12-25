# frozen_string_literal: true

class SendingEmailWhenSubscribeJob < ApplicationJob
  def perform(user_id)
    UserMailer.subscribe_email(user_id).deliver_later
  end
end
