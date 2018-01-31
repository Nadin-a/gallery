require 'rails_helper'

RSpec.describe ParsingImagesJob, type: :job do
  let!(:user) { FactoryBot.create(:random_user) }
  let!(:category) { FactoryBot.create(:fake_category, owner: user) }
  describe '#perform_later' do
    it 'parsing images' do
      ActiveJob::Base.queue_adapter = :test
      expect {
        ParsingImagesJob.perform_later('', user.id, category.id)
      }.to have_enqueued_job
    end
  end
end
