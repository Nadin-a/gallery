# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content 'some content'
    user {FactoryBot.build(:user)}
    image {FactoryBot.build(:image)}
  end

  factory :random_comments, class: Comment do
    content Faker::Lorem.word
    user {FactoryBot.build(:user)}
    image {FactoryBot.build(:image)}
  end
end
