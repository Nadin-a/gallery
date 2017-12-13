ActiveAdmin.register User do
  actions :all
  permit_params :name, :email, :avatar, :confirmed_at

  index do
    id_column
    column :name
    column :email
    column :avatar
    column :confirmed_at
    actions
  end

  form do |f|
    f.inputs 'Details' do
      f.input :name
      f.input :email
      f.input :avatar
      f.input :confirmed_at
      f.actions
    end
  end
end
