class LikePolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user
  end

  def update?
    true if user && user == like.user
  end

  def destroy?
    true if user && user == like.user
  end

  private

  def like
    record
  end
end