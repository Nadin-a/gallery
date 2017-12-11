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

15.times do |n|
  title = Faker::Lorem.word
  description = Faker::Lorem.sentence
  picture = Rails.root.join("app/assets/images/test_picture.jpg").open
  Image.create!(title: title,
                description: description,
                picture: picture,
                category_id: Random.rand(1..3))
end

20.times do |n|
  content = Faker::Lorem.word
  Comment.create!(content: content,
                  user_id: Random.rand(1..3),
                  image_id: Random.rand(1..15))
end

users = User.all
users.each { |user| user.categories << Category.find(Random.rand(1..3)) }

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?