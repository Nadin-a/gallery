# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :owned_categories, dependent: :destroy, foreign_key: :owner_id, class_name: 'Category'
  has_and_belongs_to_many :categories
  has_many :comments, dependent: :destroy, class_name: 'Comment'
  has_many :commented_images, through: :comments, source: :image

  has_many :likes, dependent: :destroy, class_name: 'Like'
  has_many :liked_images, through: :likes, source: :image

  validates :name, presence: true, length: { maximum: 50 }

  def feed
    @feed = Image.where(category_id: categories).or(Image.where(category_id: owned_categories))
  end

  def subscribe?(category)
    categories.include? category
  end

  def like?(image)
    liked_images.include? image
  end
end
