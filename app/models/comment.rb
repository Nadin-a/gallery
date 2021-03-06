# frozen_string_literal: true

class Comment < ApplicationRecord
  default_scope { order(created_at: :asc) }
  scope :last_comments, -> { unscoped.order(created_at: :desc) }

  belongs_to :user
  belongs_to :image

  validates :user, :image, presence: true
  validates :content, presence: true, length: { maximum: 200 }

  after_create_commit do
    CommentJob.perform_later(id)
    if user != image.category.owner
      Notification.create(recipient: image.category.owner,
                          type_of_notification: 'comment', participant: user.name,
                          object: image.title + ': ' + content)
    end
  end
end
