# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name 'Cars'
    owner { FactoryBot.build(:user) }

    factory :uncorrect_category do
      name ''
    end

    factory :random_category do
      name Faker::Name.first_name
    end
  end
end
