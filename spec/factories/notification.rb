# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    recipient { FactoryBot.build(:user) }
    type_of_notification 'like'
  end
end
