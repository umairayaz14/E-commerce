# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def edit?
    update?
  end

  def create?
    user.id != record.user_id
  end

  def update?
    user == comment.user
  end

  def destroy?
    update?
  end

  private

  def comment
    record
  end
end
