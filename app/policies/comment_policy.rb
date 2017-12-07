# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true if user
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