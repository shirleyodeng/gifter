class ParticipationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    true
  end

  def update?
    record.user == user
  end
end
