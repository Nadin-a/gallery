# # frozen_string_literal: true
#
# require 'rails_helper'
#
# RSpec.describe SendEmailWhenNewImageJob, type: :job do
#
#   it 'send email to sidekiq' do
#     user = FactoryBot.create(:random_user)
#     expected =  expect do
#       SendEmailWhenNewImageJob.set(queue: :mailers).perform_later user.id
#     end
#     expected.to change(Sidekiq::Worker.jobs, :size).by(1)
#   end
# end
