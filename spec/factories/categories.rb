# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name 'Cars'
    owner { FactoryBot.build(:user) }
    cover { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'test_picture.jpg'), 'image/jpeg') }

    factory :uncorrect_category do
      name ''
    end

    factory :random_category do
      name { Faker::Name.first_name }
    end

    factory :fake_category do
      name { Faker::Name.first_name }
      owner { FactoryBot.create(:random_user) }
    end
  end
end
