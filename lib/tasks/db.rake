# frozen_string_literal: true

namespace :db do
  desc 'From folder to db'
  task fill_db: :environment do
    categories = Dir.entries('/home/trofimova/gallery content').reject { |f| File.directory? f }
    categories.each do |category_name|
      cat = Category.new
      cat.name = category_name
      cat.owner_id = Random.rand(1..3)
      cat.save!
      category = Category.first

      images = Dir.entries('/home/trofimova/gallery content/' + category_name).reject { |f| File.file? f }

      images.each do |image_title|
        next if image_title == '.' || image_title == '..'
        img = Image.new
        img.title = image_title.sub(/\.[^.]+\z/, '')
        img.picture = File.open('/home/trofimova/gallery content/' + category_name + '/' + image_title)
        img.description = ''
        img.category_id = category.id
        img.save!
      end
      category.update_attribute(:cover, category.images.sample.picture)
    end
  end
  task likes: :environment do
    Image.all.each do |image|
      like = Like.new
      like.image_id = image.id
      like.user_id = 1
      like.save!
    end
  end
end
