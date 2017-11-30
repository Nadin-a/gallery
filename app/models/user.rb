# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :subscriptions,
           class_name:  'Subscription',
           foreign_key: :category_id,
           dependent: :destroy

  has_many :categories,
           through: :subscriptions,
           source: :category

  validates :name,
            presence: true,
            length: { maximum: 50 }

  has_many :categories,
           dependent: :destroy

end
