# frozen_string_literal: true

ActiveAdmin.register_page 'Get images' do
  page_action :founded_images, method: :post do
    url = params['field_for_link']
    category = Category.create(name: params['category_name'], owner: current_user)
    if category.persisted? && !url.empty?
      ParsingImagesJob.perform_later(url, category.id, current_user.id)
      redirect_to admin_get_images_path, flash: { success: t('pictures_started_uploaded') }
    else
      redirect_to admin_get_images_path, flash: { error: category.errors.full_messages }
    end
  end

  content do
    form action: 'get_images/founded_images', method: :post do |f|
      f.label :name
      f.input :category_name, type: :text, name: 'category_name'
      f.input :field_for_link, type: :text, name: 'field_for_link'
      f.input :submit, type: :submit
    end
    div id: 'snackbar' do
      div class: 'new_notification'
    end
  end
end
