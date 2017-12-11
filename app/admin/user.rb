ActiveAdmin.register User do
  actions :all
  permit_params :name, :email, :avatar, :password, :password_confirmation

  index do
    id_column
    column :name
    column :email
    column :avatar
    actions
  end

  form do |f|
    f.inputs 'Details' do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :avatar
      f.actions
    end
  end
end
