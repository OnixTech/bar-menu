class SubitemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def initialize(current_user, subitem)
    @current_user = current_user
    @subitem = subitem
  end

  def create?
    true # user_active || authorize_master
  end

  def new?
    create?
  end

  def update?
    user_active || authorize_master
  end

  def destroy?
    authorize_user || authorize_master
  end

  private

  def authorize_user
    true
  end

  def authorize_master
    @current_user.role.name == "master"
  end

  def user_active
    @current_user.active?
  end
end
