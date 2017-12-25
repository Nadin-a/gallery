# frozen_string_literal: true

ActiveAdmin.register Image do
  actions :all
  permit_params :title, :description, :picture, :category_id
end

