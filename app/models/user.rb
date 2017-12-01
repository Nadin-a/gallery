# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :owned_categories, dependent: :destroy, foreign_key: :owner_id, class_name: 'Category'

  has_and_belongs_to_many :categories

  validates :name, presence: true, length: { maximum: 50 }

  def subscribe?(category)
    categories.include? category
  end
end
