class ItemPolicy < ApplicationPolicy
  attr_reader :user, :item

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
     def resolve
       scope.all
     end
  end
  
  def initializa(user, item)
    @user = user
    @item = item
  end  

  def update?
    @user.present? && @user.active?
  end
end
