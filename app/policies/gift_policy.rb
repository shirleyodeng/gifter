class GiftPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    true
  end

  def create?
    is_user_creator?
  end

  def update?
    is_user_creator?
  end

  def destroy?
    is_user_creator?
  end

  private

  def is_user_creator?
    record.event.creator == user
  end
end
