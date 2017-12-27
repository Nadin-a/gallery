#frozen_string_literal: true

require 'rails_helper'

RSpec.describe SendEmailWhenNewImageJob, type: :job do

  it 'send email to sidekiq' do
    user = FactoryBot.create(:random_user)
    expect{
      SendEmailWhenNewImageJob.set(queue: :mailers).perform_later user.id
    }.to change( Sidekiq::Worker.jobs, :size ).by(1)
  end
end
