class FeedbackPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

  def update?
    record_owner? || user&.staff_role?
  end

  def destroy?
    record_owner? || user&.staff_role?
  end
end
