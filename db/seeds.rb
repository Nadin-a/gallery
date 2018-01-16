User.create!(name: 'Nadiia',
             email: 'example@example.org',
             password: 'password',
             password_confirmation: 'password',
             remote_avatar_url: Faker::Avatar.image,
             admin: true,
             confirmed_at: Time.current)
User.create!(name: 'Susan',
             email: 'susan@email.org',
             password: 'password',
             password_confirmation: 'password',
             remote_avatar_url: Faker::Avatar.image,
             confirmed_at: Time.current)
User.create!(name: 'a'*30,
             email: 'larry@mail.org',
             password: 'password',
             password_confirmation: 'password',
             remote_avatar_url: Faker::Avatar.image,
             confirmed_at: Time.current)

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', confirmed_at: Time.current)


if Rails.env.development?
  Category.create!(name: 'a'*15,
                   owner_id: 1,
                   cover: Rails.root.join('app/assets/images/large-photo.jpeg').open)
  Category.create!(name: 'category2',
                   owner_id: 2,
                   cover: Rails.root.join('app/assets/images/large-photo.jpeg').open)
  Category.create!(name: 'category3',
                   owner_id: 3,
                   cover: Rails.root.join('app/assets/images/big_image.jpg').open)


  15.times do
    rand = Random.rand(1..2)
    title = Faker::Name.first_name
    description = Faker::Lorem.paragraph
    picture =
    if rand == 1
      Rails.root.join('app/assets/images/big_image.jpg').open
    else
      Rails.root.join('app/assets/images/large-photo.jpeg').open
    end
    Image.create!(title: title,
                  description: description,
                  picture: picture,
                  category_id: Random.rand(1..3))
  end

  Image.create!(title: 'a' * 20,
                description: 'a' * 300,
                picture: Rails.root.join('app/assets/images/large-photo.jpeg').open,
                category_id: Random.rand(1..3))

  20.times do
    content = Faker::Lorem.paragraph
    Comment.create!(content: content,
                    user_id: Random.rand(1..3),
                    image_id: Random.rand(1..15))
  end

  Comment.create!(content: 'a'*300,
                  user_id: Random.rand(1..3),
                  image_id: Random.rand(1..15))

15.times do |n|
  Like.create!(user_id: Random.rand(1..3), image_id: n+1)
end


  users = User.all
  users.each do |user|
    category = Category.find(Random.rand(1..3))
    user.categories << category if user != category.owner
  end
end


