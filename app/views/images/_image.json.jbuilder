# frozen_string_literal: true

json.call(image, :id, :title, :created_at, :updated_at)

json.likes image.likes.count
json.like_path category_image_likes_path(@category, @image)
if @like.id.present?
  json.unlike_path category_image_like_path(@category, @image, @like)
end
