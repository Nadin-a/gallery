# frozen_string_literal: true

class ParsingImagesJob < ApplicationJob
  queue_as :default

  def perform(url, category_id)
    images = []
    Image.transaction do
      Nokogiri::HTML(open(url)).xpath('//img/@src').each do |src|
        host = URI(url).host
        pic =
        if src.to_s.start_with?('http')
          src
        else
          URI::HTTP.build(host: host, path: src)
        end
        url = pic.to_s
        image = Image.new
        title = url.split('/').last
        next if title.length > 20
        image.title = Faker::Name.first_name
        image.category = Category.find(category_id)
        image.remote_picture_url =  url
        p '------------------------------------------'
        p image.remote_picture_url
        image.save!
      end
    end
  end
end
