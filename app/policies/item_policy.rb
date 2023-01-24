class ItemPolicy < ApplicationPolicy
  attr_reader :user, :item

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
     def resolve
       scope.all
     end
  end
  
  def initialize(current_user, item)
    @current_user = current_user
    @item = item
  end  

  def update?
    (authorize_user && user_active)|| authorize_master

  end

  def create?
    (authorize_user && user_active) || authorize_master
  end

  def destroy?
    (authorize_user && user_active) || authorize_master
  end

  private

  def authorize_user
    @current_user == @item.menu.company.user
  end

  def authorize_master
    @current_user.role.name == "master"
  end

  def user_active
    @current_user.active?
  end
end
