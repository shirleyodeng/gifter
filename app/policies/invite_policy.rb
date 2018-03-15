class InvitePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def resend?
    record.event.creator == user
  end
end
