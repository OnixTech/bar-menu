class CompanyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == "master"
        scope.all
      else
        scope.where(user: user)
      end
    end
  end

  def initialize(current_user, company)
    @current_user = current_user
    @company = company
  end

  def show?
    true
  end

  def create?
    true#user_active || authorize_master
  end

  def new?
    create?
  end

  def edit?
    authorize_user || authorize_master
  end

  def update?
    user_active || authorize_master
  end

  def destroy?
    authorize_user || authorize_master
  end

  def qr?
    authorize_user || authorize_master
  end


  private

  def authorize_user
    @current_user.id == @company.user_id
  end

  def authorize_master
    @current_user.role.name == "master"
  end

  def user_active
    @current_user.active?
  end

end
