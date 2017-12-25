# frozen_string_literal: true

class ImagePolicy < ApplicationPolicy
  def create?
    image.category.owner == user
  end

  def update?
    image.category.owner == user || user.admin?
  end

  def destroy?
    image.category.owner == user || user.admin?
  end

  private

  def image
    record
  end
end
