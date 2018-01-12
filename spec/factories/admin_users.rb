# frozen_string_literal: true

FactoryBot.define do
  factory :admin_user do
    email 'nadia@example.com'
    password 'password'
    password_confirmation 'password'
    confirmed_at { Time.now }
  end
end
