class ProductPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    user == product.user
  end

  def destroy?
    user == product.user
  end

  private

  def product
    record
  end
end
