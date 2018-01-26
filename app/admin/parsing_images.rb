# frozen_string_literal: true

ActiveAdmin.register_page 'Get images' do
  page_action :founded_images, method: :post do
    url = params['field_for_link']
    begin
      category = Category.new
      category.name = params['category_name']
      category.owner = current_user
      category.save!
      ParsingImagesJob.perform_later(url, category.id)
      redirect_to admin_get_images_path
    rescue Errno::ENOENT => err
      redirect_to admin_get_images_path
    rescue ActiveRecord::RecordInvalid  => err
      redirect_to admin_get_images_path
    end
  end

  content do
    form action: 'get_images/founded_images', method: :post do |f|
      f.label :name
      f.input :category_name, type: :text, name: 'category_name'
      f.input :field_for_link, type: :text, name: 'field_for_link'
      f.input :submit, type: :submit
    end
  end
end
