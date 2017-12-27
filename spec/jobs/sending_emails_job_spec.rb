#frozen_string_literal: true

require 'rails_helper'

RSpec.describe SendingEmailWhenSubscribeJob, type: :job do

  it 'send email to sidekiq' do
    user = FactoryBot.create(:random_user)
    expect{
      SendingEmailWhenSubscribeJob.set(queue: :mailers).perform_later user.id
    }.to change( Sidekiq::Worker.jobs, :size ).by(1)
  end
end
