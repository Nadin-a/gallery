# frozen_string_literal: true

namespace :fill_with do
  desc 'From folder to db'
  task categories_and_images: :environment do
    path = select_path_to_folder
    default_path = Dir.glob("#{path + '/'}*.{jpg,gif,png,jpeg}")
    create_category('default', path)  unless default_path.empty?
    path_to_categories = Dir.glob("#{path}/**/*").select! { |f| File.directory? f }
    Category.transaction do
      path_to_categories.each do |category_path|
        name = category_path.split('/').last
        next if name.length > 20
        create_category(name, category_path)
      end
    end
  end

  def select_path_to_folder
    choice = 0
    until choice == 1 || choice == 2
      p '1) Use default path 2) Enter your path'
      choice = STDIN.gets.to_i
    end
    case choice
    when 1
      p 'Default path is app/assets/images/'
      'app/assets/images/'
    when 2
      p 'Enter your path end with /'
      STDIN.gets.strip
    end
  end

  def create_category(name, category_path)
    category = Category.create(name: name, owner_id: User.all.ids.sample)
    if category.persisted?
      p 'Category ' + name + ' created!'
      migrate_images(name, category_path)
    end
  end

  def migrate_images(category_name, path)
    category = Category.find_by(name: category_name)
    images_path = Dir.glob("#{path + '/'}*.{jpg,gif,png,jpeg}")
    Image.transaction do
      images_path.each do |image_path|
        img = Image.create(title: image_path.sub(/\.[^.]+\z/, '').split('/').last,
                           picture: File.open(image_path), category: category)
        if img.persisted?
          p 'Image ' + img.title + ' saved!'
          category.update_attribute(:cover, category.images.sample.picture)
        end
      end
    end
  end
end
