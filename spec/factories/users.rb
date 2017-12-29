# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name 'Nadia'
    email 'nadia@example.com'
    password 'password'
    password_confirmation 'password'
    confirmed_at Time.now

    factory :random_user do
      name { Faker::Name.first_name }
      email { Faker::Internet.safe_email }
    end

    factory :admin do
      name { Faker::Name.first_name }
      email { Faker::Internet.safe_email }
      admin true
    end
  end
end
