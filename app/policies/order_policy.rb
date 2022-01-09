class OrderPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    index?
  end

  def create?
    index?
  end

  def new?
    index?
  end

  def update?
    user == order.user
  end

  def edit?
    update?
  end

  def destroy?
    user == order.user || user.admin?
  end

  private

  def order
    record
  end
end
