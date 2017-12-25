# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def create?
    user
  end

  def destroy?
    user.admin?
  end

  private

  def comment
    record
  end
end
