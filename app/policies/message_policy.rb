# frozen_string_literal: true

class MessagePolicy < ApplicationPolicy
  def create?
    user
  end

  def destroy?
    user.admin?
  end

  private

  def message
    record
  end
end
