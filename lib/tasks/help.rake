# frozen_string_literal: true

namespace :db do
  desc 'Add fields to existing models'
  task go_friendly_id: :environment do
    User.find_each(&:save)
    Category.find_each(&:save)
    Image.find_each(&:save)
    Room.find_each(&:save)
  end
end
