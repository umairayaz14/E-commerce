class ProductPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def update?
    user.present? && user == product.user
  end

  def destroy?
    user.present? && user == product.user
  end

  private

  def product
    record
  end
end
