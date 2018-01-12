# frozen_string_literal: true

FactoryBot.define do
  factory :image do
    title 'title'
    description 'some description'
    picture { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'test_picture.jpg'), 'image/jpeg') }
    # remote_picture_url Faker::Avatar.image
    category { FactoryBot.build(:category) }

    factory :random_image do
      title { Faker::Name.first_name }
      description { Faker::Lorem.sentence }
      remote_picture_url { Faker::Avatar.image }
    end

    factory :invalid_image do
      title ''
    end
  end
end
