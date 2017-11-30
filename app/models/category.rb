# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :subscribers,
           class_name:  'Subscription',
           foreign_key: :user_id,
           dependent: :destroy

  has_many :users,
           through: :subscribers,
           source: :user

  validates :user, presence: true
  validates :name,
            presence: true,
            length: { maximum: 30 }

  belongs_to :user
end