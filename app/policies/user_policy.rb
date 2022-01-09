class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    index?
  end

  def update?
    user.admin?
  end

  def edit?
    update?
  end
end
