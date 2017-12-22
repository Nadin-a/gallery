# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :async,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: %i[facebook]

  has_many :owned_categories, dependent: :destroy, foreign_key: :owner_id, class_name: 'Category'
  has_and_belongs_to_many :categories
  has_many :comments, dependent: :destroy, class_name: 'Comment'
  has_many :commented_images, through: :comments, source: :image
  has_many :likes, dependent: :destroy, class_name: 'Like'
  has_many :liked_images, through: :likes, source: :image

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validate  :avatar_size

  def feed
    @feed = Image.where(category_id: categories).or(Image.where(category_id: owned_categories))
  end


  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def send_email_about_subscribtion
    SendingEmailsJob.perform_later self.id
  end

  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0,20]
  #     user.name = auth.info.name   # assuming the user model has a name
  #     user.avatar = auth.info.image # assuming the user model has an image
  #     # If you are using confirmable and the provider(s) you use validate emails,
  #     # uncomment the line below to skip the confirmation emails.
  #     # user.skip_confirmation!
  #   end
  # end
  #
  # def self.new_with_session(params, session)
  #   super.tap do |user|
  #     if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
  #       user.email = data["email"] if user.email.blank?
  #     end
  #   end
  # end

  private

  def avatar_size
    return unless avatar.size > 5.megabytes
    errors.add(:avatar, 'should be less than 5MB')
  end
end
