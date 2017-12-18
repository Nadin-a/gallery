ActiveAdmin.register_page 'Get images' do

  page_action :founded_images, method: :post do
    images = []
    url = params['my_field']
    begin
      Nokogiri::HTML(open(url)).xpath('//img/@src').each do |src|
        host = URI(params['my_field']).host
        p src
        pic =
          if host == 'localhost'
            "http://#{host}:3000/#{src}"
          else
            if src.to_s.start_with?('http')
              src
            else
              URI::HTTP.build({host: host, path: src})
            end
          end
        images << pic
      end
      render 'found_pictures', locals: {images: images}
    rescue Errno::ENOENT => e
      redirect_to admin_get_images_path
    end
  end

  content do
    form action: 'get_images/founded_images', method: :post do |f|
      f.input :my_field, type: :text, name: 'my_field'
      f.input :submit, type: :submit
    end
  end

end