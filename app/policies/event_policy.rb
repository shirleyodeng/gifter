class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(creator: user)
    end
  end

  def create?
    return true
  end

  def destroy?
    record.creator == user
  end
end
