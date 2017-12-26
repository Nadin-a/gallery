# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    user { FactoryBot.build(:user) }
    image { FactoryBot.build(:image) }
  end
end
