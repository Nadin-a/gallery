# frozen_string_literal: true

# require 'rails_helper'
#
# RSpec.describe "Test sending email with sidekiq", :type => :request do
#   let!(:user) { FactoryBot.create(:random_user) }
#
#   it 'send email to sidekiq' do
#     user = User.first
#     expect{
#       SendingEmailWhenSubscribeJob.set(queue: :mailers).perform_later user.id
#     }.to change( Sidekiq::Worker.jobs, :size ).by(1)
#
#   end
#
# end
#
