# # frozen_string_literal: true
#
# class SendNewsJob < ApplicationJob
#   def perform(user_id)
#     UserMailer.news(user_id).deliver_later
#   end
# end
#
# Sidekiq::Cron::Job.create(name: 'Sending news - every 24 hours', cron: '*/5 * * * *', class: 'SendNewsJob')
