# frozen_string_literal: true

require 'spec_helper'
describe NotificationHelper, type: :helper do
  let!(:notification) { FactoryBot.create(:notification) }
  let!(:like_notification) { FactoryBot.create(:notification, type_of_notification: 'like') }
  let!(:subscribe_notification) { FactoryBot.create(:notification, type_of_notification: 'subscribe') }
  let!(:comment_notification) { FactoryBot.create(:notification, type_of_notification: 'comment') }
  describe 'forming notification' do
    it 'form like notification' do
      expect(helper.form_notification(like_notification)).to have_content('liked your image')
    end
    it 'form subscribe notification' do
      expect(helper.form_notification(subscribe_notification)).to have_content('started following your category')
    end
    it 'form comment notification' do
      expect(helper.form_notification(comment_notification)).to have_content('commented your image')
    end
    it 'form default notification' do
      expect(helper.form_notification(notification)).to have_content('file')
    end
  end
end
