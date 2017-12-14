# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content 'some content'
    user { FactoryBot.build(:user) }
    image { FactoryBot.build(:image) }

    factory :random_comment do
      content Faker::Lorem.word
    end

    factory :invalid_comment do
      content ''
    end
  end
end
