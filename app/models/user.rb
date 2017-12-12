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

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true, length: { maximum: 20 }, uniqueness: true
  validate  :avatar_size

  def feed
    @feed = Image.where(category_id: categories).or(Image.where(category_id: owned_categories))
  end

  private

  def avatar_size
    return unless avatar.size > 5.megabytes
    errors.add(:avatar, 'should be less than 5MB')
  end
end
