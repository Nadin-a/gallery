# frozen_string_literal: true

FactoryBot.define do
  factory :image do
    title 'title'
    description 'some description'
    picture Rails.root.join("app/assets/images/test_picture.jpg").open
    category {FactoryBot.build(:category) }
  end

  factory :random_image, class: Image do
    title Faker::Lorem.word
    description Faker::Lorem.sentence
    picture Rails.root.join("app/assets/images/test_picture.jpg").open
    category {FactoryBot.build(:category) }
  end
end
