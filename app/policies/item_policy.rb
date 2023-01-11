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
    @current_user == @item.menu.company.user && @current_user.active || current_user.role == "master" && current_user.active
  end
end
