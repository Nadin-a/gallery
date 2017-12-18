# frozen_string_literal: true

class ImagePolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    image.category.owner == user
  end

  def update?
    image.category.owner == user
  end

  def destroy?
    image.category.owner == user
  end

  private

  def image
    record
  end
end
