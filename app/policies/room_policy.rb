# frozen_string_literal: true

class RoomPolicy < ApplicationPolicy
  def index?
    user
  end

  def create?
    user
  end

  def show?
    user
  end

  def update?
    user == room.user || user.admin?
  end
  alias destroy? update?

  private

  def room
    record
  end
end
