User.create!(name: 'Nadia',
             email: 'example@example.org',
             password: 'password',
             password_confirmation: 'password',
             confirmed_at: Time.now)
User.create!(name: 'Susan',
             email: 'susan@email.org',
             password: 'password',
             password_confirmation: 'password',
             confirmed_at: Time.now)
User.create!(name: 'Larry',
             email: 'larry@mail.org',
             password: 'password',
             password_confirmation: 'password',
             confirmed_at: Time.now)

Category.create!(name: 'cars',
                 owner_id: 1)
Category.create!(name: 'cats',
                 owner_id: 2)
Category.create!(name: 'cities',
                 owner_id: 3)


15.times do
  rand = Random.rand(1..2)
  title = Faker::Name.first_name
  description = Faker::Lorem.sentence
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
  content = Faker::Lorem.word
  Comment.create!(content: content,
                  user_id: Random.rand(1..3),
                  image_id: Random.rand(1..15))
end

15.times do |n|
    Like.create!(user_id: Random.rand(1..3), image_id: n+1)
end


users = User.all
users.each do |user|
  category = Category.find(Random.rand(1..3))
  user.categories << category if user != category.owner
end


AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', confirmed_at: Time.now) if Rails.env.development?