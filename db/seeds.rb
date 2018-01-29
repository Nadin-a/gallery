# frozen_string_literal: true

User.transaction do
  User.create!(name: 'Nadiia',
               email: 'example@example.org',
               password: 'password',
               password_confirmation: 'password',
               #remote_avatar_url: Faker::Avatar.image,
               admin: true,
               confirmed_at: Time.current)

  User.create!(name: 'Susan',
               email: 'susan@email.org',
               password: 'password',
               password_confirmation: 'password',
               #remote_avatar_url: Faker::Avatar.image,
               confirmed_at: Time.current)

  User.create!(name: 'a' * 30,
               email: 'larry@mail.org',
               password: 'password',
               password_confirmation: 'password',
               #remote_avatar_url: Faker::Avatar.image,
               confirmed_at: Time.current)
end

user_ids = User.all.ids

if Rails.env.development?
  Category.transaction do
    User.find(user_ids.sample).owned_categories.create(
      name: 'a' * 15,
      cover: Rails.root.join('app/assets/images/large-photo.jpeg').open
    )

    User.find(user_ids.sample).owned_categories.create(
      name: 'category2',
      cover: Rails.root.join('app/assets/images/large-photo.jpeg').open
    )

    User.find(user_ids.sample).owned_categories.create(
      name: 'category3',
      cover: Rails.root.join('app/assets/images/big_image.jpg').open
    )

    category_ids = Category.all.ids
    15.times do
      picture_name = %w[big_image.jpg large-photo.jpeg].freeze.sample
      picture = Rails.root.join('app', 'assets', 'images', picture_name).open
      Image.create!(title: Faker::Name.first_name,
                    description: Faker::Lorem.paragraph,
                    picture: picture,
                    category_id: category_ids.sample)
    end

    Image.create!(title: 'a' * 20,
                  description: 'a' * 300,
                  picture: Rails.root.join('app/assets/images/large-photo.jpeg').open,
                  category_id: category_ids.sample)

    image_ids = Image.all.ids

    20.times do
      content = Faker::Lorem.sentence
      Comment.create!(content: content,
                      user_id: user_ids.sample,
                      image_id: image_ids.sample)
    end

    Comment.create!(content: 'a' * 200,
                    user_id: user_ids.sample,
                    image_id: image_ids.sample)

    15.times { |n| Like.create!(user_id: user_ids.sample, image_id: n + 1) }


    User.all.each do |user|
      category = Category.find(category_ids.sample)
      user.categories << category if user != category.owner
    end
  end
end


