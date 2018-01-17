# frozen_string_literal: true

ActiveAdmin.register Image do
  actions :all
  permit_params :title, :description, :picture, :category_id

  csv do
    column :title
    column :description
    column (:category) {|image| image.category.name}
  end

end
