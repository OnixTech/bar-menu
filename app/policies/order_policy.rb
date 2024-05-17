class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == "master"
        scope.all
      else
        scope.joins(station: :company).where(companies: { user_id: user.id })
      end
    end
  end

  def create?
    patovica
  end

  def update?
    patovica
  end

  def destroy?
    patovica
  end

  private

  def authorize_user
    @current_user.email == "pablo@puente.com"
  end

  def authorize_master
    @current_user.role.name == "master"
  end

  def patovica
    authorize_user || authorize_master
  end
end
