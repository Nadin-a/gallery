# frozen_string_literal: true

class CopyWorker
  include Sidekiq::Worker

  def perform(category_id)
    category = Category.find(category_id)
    new_category = Category.copy_category(category.attributes)
    category.images.find_each do |image|
      picture =
        if Rails.env.production?
          image.picture.url
        else
          image.picture.current_path
        end
      Image.copy_image(image.attributes, new_category.id, picture)
    end
  end
end
