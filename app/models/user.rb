# frozen_string_literal: true

class User < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  scope :active, -> { where.not(confirmed_at: nil).order(created_at: :desc) }
  scope :subscribe_on_emails, -> { where(receive_emails: true) }

  has_many :owned_categories, dependent: :destroy, foreign_key: :owner_id, class_name: 'Category'
  has_and_belongs_to_many :categories
  has_many :comments, dependent: :destroy
  has_many :commented_images, through: :comments, source: :image
  has_many :likes, dependent: :destroy
  has_many :liked_images, through: :likes, source: :image
  has_many :owned_rooms, dependent: :destroy, class_name: 'Room'
  has_many :messages, dependent: :destroy
  has_many :ahoy_events, dependent: :destroy, class_name: 'Ahoy::Event'
  has_many :notifications, dependent: :destroy, foreign_key: :recipient_id, class_name: 'Notification'

  validates :name, presence: true, length: { minimum: 2, maximum: 30 }, uniqueness: true
  validate :avatar_size

  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable, :confirmable, :async,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         omniauth_providers: %i[facebook twitter google_oauth2]

  def self.create_with_omniauth(auth)
    user = find_or_create_by(uid: auth['uid'], provider: auth['provider'])
    user.email = auth.info.email
    user.password = Devise.friendly_token[0, 20]
    user.name = auth.info.name
    url = auth.info.image
    avatar_url = url.gsub('http', 'https') unless url.include? 'https'
    user.remote_avatar_url = avatar_url
    user.confirmed_at = Time.current
    user.save!
    user
  end

  def feed
    Image.where(category_id: category_ids | owned_category_ids)
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def send_email_about_subscribtion
    SendingEmailWhenSubscribeJob.set(queue: :mailer).perform_later id if receive_emails?
  end

  def send_email_about_new_image(image)
    SendEmailWhenNewImageJob.set(queue: :mailer).perform_later id, image if receive_emails?
  end

  def should_generate_new_friendly_id?
    name_changed?
  end

  def normalize_friendly_id(text)
    text.to_slug.transliterate(:russian).normalize.to_s
  end

  def read_all
    notifications.where(readed: false).update_all(readed: true)
  end

  private

  def avatar_size
    return unless avatar.size > 5.megabytes
    errors.add(:avatar, I18n.t('size_error', size: '5MB'))
  end
end
