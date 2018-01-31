# frozen_string_literal: true

require 'rails_helper'
RSpec.describe SendingEmailWhenSubscribeJob, type: :job do
  let!(:user) { FactoryBot.create(:random_user) }

  describe '#perform_later' do
    it 'send email about subscribe' do
      ActiveJob::Base.queue_adapter = :test
      expectation = expect do
        SendingEmailWhenSubscribeJob.perform_later(user.id)
      end
      expectation.to have_enqueued_job
    end
  end
end
