class StationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.companies.present?
        company_ids = user.companies.pluck(:id)
        scope.where(company_id: company_ids)
      else
        scope.joins(station: :company).where(companies: { user_id: user.id })
      end
    end
  end

  def initialize(current_user, station)
    @current_user = current_user
    @station = station
  end

  def show?
    authorize_user
  end

  def create?
    true # user_active || authorize_master
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  def update?
    user_active || authorize_master
  end

  def destroy?
    authorize_user || authorize_master
  end

  private

  def authorize_user
    @current_user == @station.company.user
  end

  def authorize_master
    @current_user.role.name == "master"
  end

  def user_active
    @user.active?
  end
end
