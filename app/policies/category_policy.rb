# frozen_string_literal: true

class CategoryPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user
  end

  def update?
    user == category.owner || user.admin?
  end
  alias destroy? update?

  def owned?
    user
  end

  def favorite?
    user
  end

  def followers?
    true
  end

  def subscribe?
    user != category.owner
  end
  alias unsubscribe? subscribe?

  private

  def category
    record
  end
end
