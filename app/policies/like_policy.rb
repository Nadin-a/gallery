# frozen_string_literal: true

class LikePolicy < ApplicationPolicy

  def create?
    true if user
  end

  def destroy?
    user == like.user
  end

  private

  def like
    record
  end
end
