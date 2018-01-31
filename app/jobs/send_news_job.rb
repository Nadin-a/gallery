# frozen_string_literal: true

class SendNewsJob < ApplicationJob
  def perform
    return unless Category.new_categories_in_24.count.positive? || Image.new_images_in_24.count.positive? ||
    Room.new_rooms_in_24.count.positive?
    ReportMailer.news.deliver_later
  end
end
