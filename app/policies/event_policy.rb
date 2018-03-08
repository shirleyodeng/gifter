class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(creator: user)
    end
  end

  def create?
    true
  end

  def update?
    is_user_creator?
  end

  def destroy?
    is_user_creator?
  end

  private

  def is_user_creator?
    record.creator == user
  end
end
