class CompanyPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def index?
    user.role == "master"
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def edit?
    @current_user == @company
  end

  def update?
    true
  end

  def destroy?
    record.user == user
  end
end
