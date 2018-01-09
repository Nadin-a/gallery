# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :async,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         omniauth_providers: [:facebook]

  has_many :owned_categories, dependent: :destroy, foreign_key: :owner_id, class_name: 'Category'
  has_and_belongs_to_many :categories
  has_many :comments, dependent: :destroy, class_name: 'Comment'
  has_many :commented_images, through: :comments, source: :image
  has_many :likes, dependent: :destroy, class_name: 'Like'
  has_many :liked_images, through: :likes, source: :image

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validate :avatar_size

  def feed
    @feed = Image.where(category_id: categories).or(Image.where(category_id: owned_categories))
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def send_email_about_subscribtion
    SendingEmailWhenSubscribeJob.set(queue: :mailers).perform_later id
  end

  def send_email_about_new_image(image)
    SendEmailWhenNewImageJob.set(queue: :mailers).perform_later id, image
  end

  def self.create_with_omniauth(auth)
    user = find_or_create_by(uid: auth['uid'], provider: auth['provider'])
    user.email = auth.info.email
    user.password = Devise.friendly_token[0, 20]
    user.name = auth.info.name
    user.remote_avatar_url = auth.info.image
    user.confirmed_at = Time.now
    user.save!
    user
  end

  private

  def avatar_size
    return unless avatar.size > 5.megabytes
    errors.add(:avatar, 'should be less than 5MB')
  end
end
