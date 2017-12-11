ActiveAdmin.register User do
  actions :all
  permit_params :name, :email, :password, :password_confirmation

  index do
    id_column
    column :name
    column :email
    actions
  end

  form do |f|
    f.inputs 'Details' do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.actions
    end
  end
end
