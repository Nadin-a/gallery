# frozen_string_literal: true

json.call(image, :id, :title, :created_at, :updated_at)

json.likes image.likes.count
json.like_path category_image_likes_path(@category, @image)
json.unlike_path category_image_like_path(@category, @image, @like) if @like.id.present?
comments = image.comments - image.comments.last(5)
json.hidden_comments = CommentsController.render partial: 'shared/hidden_list_of_comments', locals: { comments: comments }


