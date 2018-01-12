# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    content 'some message'
    user { FactoryBot.build(:user) }
    room { FactoryBot.build(:room) }

    factory :random_message do
      content { Faker::Lorem.paragraph }
    end

    factory :invalid_message do
      content ''
    end
  end
end
