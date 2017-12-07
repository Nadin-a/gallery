FactoryBot.define do
  factory :user do
    name 'Nadia'
    email 'nadia@example.com'
    password 'password'
    password_confirmation 'password'
    confirmed_at Time.now
  end

  factory :random_user, class: User do
    name { Faker::Name.first_name }
    email { Faker::Internet.safe_email }
    password 'password'
    password_confirmation 'password'
    confirmed_at Time.now
  end
end