# frozen_string_literal: true

ActiveAdmin.register Comment, as: 'UserComment' do
  actions :all
  permit_params :content, :user_id, :image_id

  csv do
    column :content
    column (:user) {|comment| comment.user.name}
    column (:image) {|comment| comment.image.title}
  end
end
