class VotePolicy < ApplicationPolicy
  def create?
    user
  end

  def destroy?
    user
  end
end
