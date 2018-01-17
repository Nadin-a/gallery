# frozen_string_literal: true

ActiveAdmin.register User do
  actions :all
  permit_params :name, :email, :avatar, :admin, :confirmed_at

  csv do
    column :name
    column :email
    column :admin
    column :sign_in_count
    column :last_sign_in_at
    column :created_at
    column :confirmed_at
    column :provider
    actions
  end

  index do
    id_column
    column :name
    column :email
    column :avatar
    bool_column :admin
    column :sign_in_count
    column :last_sign_in_at
    column :created_at
    column :confirmed_at
    column :provider
    actions
  end

  form do |f|
    f.inputs 'Details' do
      f.input :name
      f.input :email
      f.input :avatar
      f.input :admin
      f.input :confirmed_at, as: :date_time_picker
      f.actions
    end
  end
end
