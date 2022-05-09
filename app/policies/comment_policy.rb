class CommentPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def update?
    user.present? && user == comment.user
  end

  def destroy?
    user.present? && user == comment.user
  end

  private

  def comment
    record
  end
end
