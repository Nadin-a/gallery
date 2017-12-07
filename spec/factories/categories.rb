FactoryBot.define do
  factory :category do
    name 'Cars'
    owner { FactoryBot.build(:user) }
  end

  factory :random_category, class: Category do
    name Faker::Witcher.monster
    owner { FactoryBot.build(:user) }
  end
end