# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verfied_user
    end

    protected

    def find_verfied_user
      current_user = User.find_by(id: cookies.signed['user.id'])
      if current_user.present?
        current_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
