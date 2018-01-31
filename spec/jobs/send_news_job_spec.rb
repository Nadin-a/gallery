require 'rails_helper'

RSpec.describe SendNewsJob, type: :job do
  describe '#perform_later' do
    it 'send news' do
      ActiveJob::Base.queue_adapter = :test
      expect {
        SendNewsJob.perform_later
      }.to have_enqueued_job
    end
  end
end
