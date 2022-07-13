class CommentPolicy < ApplicationPolicy

  def create?
    true
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
