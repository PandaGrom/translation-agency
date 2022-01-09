class CommentPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def destroy?
    user == comment.user || user.admin?
  end

  private

  def comment
    record
  end
end
