# frozen_string_literal: true

class LikePolicy < ApplicationPolicy
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
    user == like.user
  end

  private

  def like
    record
  end
end
