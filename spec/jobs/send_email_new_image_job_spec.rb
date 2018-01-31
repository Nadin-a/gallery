require 'rails_helper'

RSpec.describe SendEmailWhenNewImageJob, type: :job do
  let!(:user) { FactoryBot.create(:random_user)}
  let!(:image) { FactoryBot.create(:random_image) }

  describe '#perform_later' do
    it 'send email about subscribe' do
      ActiveJob::Base.queue_adapter = :test
      expect {
        SendEmailWhenNewImageJob.perform_later(user.id, image.id)
      }.to have_enqueued_job
    end
  end
end
