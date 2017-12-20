# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy

  def create?
    true if user
  end

  private

  def comment
    record
  end
end
