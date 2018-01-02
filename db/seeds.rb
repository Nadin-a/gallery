if Rails.env.development?
  User.create!(name: 'Nadia',
               email: 'example@example.org',
               password: 'password',
               password_confirmation: 'password',
               remote_avatar_url: Faker::Avatar.image,
               admin: true,
               confirmed_at: Time.now)
  User.create!(name: 'Susan',
               email: 'susan@email.org',
               password: 'password',
               password_confirmation: 'password',
               remote_avatar_url: Faker::Avatar.image,
               confirmed_at: Time.now)
  User.create!(name: 'Larry',
               email: 'larry@mail.org',
               password: 'password',
               password_confirmation: 'password',
               remote_avatar_url: Faker::Avatar.image,
               confirmed_at: Time.now)

  Category.create!(name: 'category1',
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

  20.times do
    content = Faker::Lorem.paragraph
    Comment.create!(content: content,
                    user_id: Random.rand(1..3),
                    image_id: Random.rand(1..15))
  end

# 15.times do |n|
#   Like.create!(user_id: Random.rand(1..3), image_id: n+1)
# end


  users = User.all
  users.each do |user|
    category = Category.find(Random.rand(1..3))
    user.categories << category if user != category.owner
  end
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', confirmed_at: Time.now) # if Rails.env.development?