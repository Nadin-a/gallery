# frozen_string_literal: true

class SendNewsJob < ApplicationJob
  def perform
    ReportMailer.news.deliver_later
  end
end
