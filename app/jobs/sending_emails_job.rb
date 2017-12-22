class SendingEmailsJob < ApplicationJob
  include Sidekiq::Mailer
  queue_as :mailer

  # rescue_from(ArgumentError) do |exception|
  #   p exception
  # end


  def perform(user)
    UserMailer.subscribe_email(args).deliver_later
  end
end
