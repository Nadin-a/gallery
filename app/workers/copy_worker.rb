# frozen_string_literal: true

class CopyWorker
  include Sidekiq::Worker

  def perform(category_id)
    category = Category.find(category_id)
    new_category = Category.copy_category(category.attributes)
    category.images.find_each do |image|
      Image.copy_image(image.attributes, new_category.id, image.picture.current_path)
    end
  end
end
