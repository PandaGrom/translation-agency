class CommentPolicy < ApplicationPolicy
  def destroy?
    user == comment.user || user.admin?
  end

  private

  def comment
    record
  end
end
