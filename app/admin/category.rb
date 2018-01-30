# frozen_string_literal: true

ActiveAdmin.register Category do
  actions :all
  permit_params :owner_id, :name

  filter :name
  filter :created_at
  filter :owner

  csv do
    column :name
    column :created_at
    column :updated_at
    column(:owner) { |category| category.owner.name }
    column(:followers) { |category| category.users.count }
  end

  index do
    selectable_column
    column :name
    column :created_at
    column :updated_at
    column(:owner) { |category| category.owner.name }
    column(:followers) { |category| category.users.count }
    actions
  end

  member_action :copy, method: :post do
    CopyWorker.perform_async(resource.id)
    redirect_to admin_categories_path, notice: 'Category will be copied!'
  end

  action_item :copy, only: :show do
    link_to 'Copy', copy_admin_category_path, method: :post
  end
end
