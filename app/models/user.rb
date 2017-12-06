# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :owned_categories, dependent: :destroy, foreign_key: :owner_id, class_name: 'Category'
  has_and_belongs_to_many :categories
  has_many :comments, dependent: :destroy, foreign_key: :author_id, class_name: 'Comment'
  has_many :images, through: :comments

  validates :name, presence: true, length: { maximum: 50 }

  def feed
    @feed = Image.where(category_id: categories).or(Image.where(category_id: owned_categories))
  end

  def subscribe?(category)
    categories.include? category
  end
end
