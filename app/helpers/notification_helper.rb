# frozen_string_literal: true

module NotificationHelper
  def form_notification(notification)
    case notification.type_of_notification
    when 'like'
      notification.participant + t('liked_your_image') + notification.object
    when 'subscribe'
      notification.participant + t('started_following') + notification.object
    when 'comment'
      notification.participant + t('comment_your_image') + notification.object
    else
      notification.object
    end
  end
end
