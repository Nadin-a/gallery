class RoomPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user
  end

  def show?
    true
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
