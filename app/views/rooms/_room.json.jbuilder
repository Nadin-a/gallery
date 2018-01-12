# frozen_string_literal: true

json.call(room, :id, :name, :created_at, :updated_at)

json.last_message = room.messages.last
