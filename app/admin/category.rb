# frozen_string_literal: true

ActiveAdmin.register Category do
  actions :all
  permit_params :owner_id, :name

  csv do
    column :name
    column :created_at
    column :updated_at
    column (:owner) {|category| category.owner.name}
    column (:followers) {|category| category.users.count}
  end

  index  do
    selectable_column
    column :name
    column :created_at
    column :updated_at
    column (:owner) {|category| category.owner.name}
    column (:followers) {|category| category.users.count}
    actions
  end


end
