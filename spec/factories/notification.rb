# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    type_of_notification 'default'
    recipient { FactoryBot.build(:random_user) }
    participant { FactoryBot.build(:random_user) }
    object 'file'
    readed false
  end
end
