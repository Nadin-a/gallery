# frozen_string_literal: true

class Comment < ApplicationRecord
  default_scope { order(created_at: :asc) }

  belongs_to :user
  belongs_to :image

  scope :last_comments, -> { unscoped.order(created_at: :desc) }

  validates :user, :image, presence: true
  validates :content, presence: true, length: { maximum: 200 }

  after_create_commit do
    CommentJob.perform_later(id)
    if self.user != image.category.owner
      Notification.create(recipient: image.category.owner,
                          type_of_notification: 'comment', participant: user.name,
                          object: image.title + ': ' + content)
    end
  end
end
