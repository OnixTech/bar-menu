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
    true
  end

  def update?
    true
  end

  def destroy?
    true
  end

  private

  def authorize_user
    @current_user.email == "pablo@puente.com" || authorize_master
  end

  def authorize_master
    @current_user.role.name == "master"
  end

  def user_active
    @current_user.active?
  end
end
