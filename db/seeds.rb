User.create!(name: 'Example User',
             email: 'example@example.org',
             password: 'password',
             password_confirmation: 'password')
Category.create!(name: 'cars',
                 user_id: 1)
Subscription.create!(user: 1,
                     category: 1)