# frozen_string_literal: true

class ParsingImagesJob < ApplicationJob
  queue_as :default

  def perform(url, category_id, user_id)
    user = User.find(user_id)
    images = Nokogiri::HTML(open(url)).xpath('//img/@src')
    succeed = 0
    errors = 0
    errors_report = []

    images.each do |src|
      host = URI(url).host
      pic = if src.to_s.start_with?('http')
              src
            else
              URI::HTTP.build(host: host, path: src)
            end
      img = Image.create(title: Faker::Number.number(10), category_id: category_id, remote_picture_url: pic.to_s)
      if img.persisted?
        succeed += 1
      else
        errors += 1
        errors_report << { error: img.errors.full_messages }
      end
    end
    main_report = { all: images.count, succeed: succeed, errors: errors }
    ReportMailer.report_about_parsing(user.email, main_report, errors_report).deliver_later
  end
end
