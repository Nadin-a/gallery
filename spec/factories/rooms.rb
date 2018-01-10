# frozen_string_literal: true

FactoryBot.define do
  factory :room do
    name 'Room1'
    user { FactoryBot.build(:user) }

    factory :uncorrect_room do
      name ''
    end

    factory :random_room do
      name Faker::Name.first_name
    end
  end
end
