# frozen_string_literal: true

class ImagePolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user && image.category.owner == user
  end

  def update?
    true if user && image.category.owner == user
  end

  def destroy?
    true if user && image.category.owner == user
  end

  private

  def image
    record
  end
end
