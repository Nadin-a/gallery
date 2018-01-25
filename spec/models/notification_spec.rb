# frozen_string_literal: true

require 'rails_helper'

describe Notification do
  subject(:notification) { FactoryBot.build(:notification) }

  it 'has a valid factory' do
    expect(FactoryBot.build(:notification)).to be_valid
  end
  it 'is not valid without a recipient' do
    notification.recipient = nil
    expect(notification).not_to be_valid
  end
  it 'is not valid without a image' do
    notification.type_of_notification = nil
    expect(notification).not_to be_valid
  end

  describe 'Associations' do
    it { is_expected.to belong_to :recipient }
    it { is_expected.to have_db_index('recipient_id') }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :recipient }
    it { is_expected.to validate_presence_of :type_of_notification }
  end
end
