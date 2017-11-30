# frozen_string_literal: true

class Subscription < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :category, class_name: 'Category'

  validates :user, presence: true
  validates :category, presence: true
end