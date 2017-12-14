# frozen_string_literal: true

FactoryBot.define do
  factory :image do
    title 'title'
    description 'some description'
    picture { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'test_picture.jpg'), 'image/jpg') }
    category

    factory :random_image do
      title Faker::Name.first_name
      description Faker::Lorem.sentence
    end

    factory :invalid_image do
      title ''
    end
  end
end
