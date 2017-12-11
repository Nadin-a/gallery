ActiveAdmin.register Comment, as: 'UserComment' do
  actions :all
  permit_params :content, :user_id, :image_id
end
