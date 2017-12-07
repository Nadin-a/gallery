class CategoryPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user
  end

  def update?
    true if user && user == category.owner
  end

  def destroy?
    true if user && user == category.owner
  end

  def owned?
    true if user
  end

  def favorite?
    true if user
  end

  def subscribe?
    true if user && user != category.owner
  end

  def unsubscribe?
    true if user && user != category.owner
  end

  private

  def category
    record
  end
end