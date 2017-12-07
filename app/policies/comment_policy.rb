class CommentPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user
  end

  def update?
    false
  end

  def destroy?
    false
  end

  private

  def comment
    record
  end
end