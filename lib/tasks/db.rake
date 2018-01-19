# frozen_string_literal: true

namespace :db do
  desc 'From folder to db'

  task migrate_categories: :environment do
    categories = Dir.entries('/home/trofimova/gallery content').reject { |f| File.directory? f }
    categories.each do |category_name|
      cat = Category.new
      cat.name = category_name
      cat.owner_id = User.all.ids.sample
      cat.save!
      migrate_images(category_name)
    end
  end

  def migrate_images(category_name)
    category = Category.find_by(name: category_name)
    images = Dir.entries('/home/trofimova/gallery content/' + category_name).reject { |f| File.file? f }
    images.select! { |file_name| file_name.end_with?('.jpg' || '.png' || '.jpeg') }
    images.each do |image_title|
      img = Image.new
      img.title = image_title.sub(/\.[^.]+\z/, '')
      img.picture = File.open('/home/trofimova/gallery content/' + category_name + '/' + image_title)
      img.category = category
      img.save!
      category.update_attribute(:cover, category.images.sample.picture)
    end
  end

  task likes: :environment do
    Image.find_each do |image|
      like = Like.new
      like.image = image
      like.user_id = User.all.ids.sample
      like.save!
    end
  end
end
