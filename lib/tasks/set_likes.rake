# frozen_string_literal: true

namespace :set_likes do
  desc 'Set likes to pictures'

  task likes: :environment do
    Image.find_each do |image|
      like = Like.new
      like.image = image
      like.user_id = User.all.ids.sample
      like.save!
    end
  end
end
