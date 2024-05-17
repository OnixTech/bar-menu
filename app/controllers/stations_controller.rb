class StationsController < ApplicationController
  before_action :set_stations, only: %i[show destroy edit update]

  def index
    @stations = policy_scope(Station)
  end

  def show
    authorize @station
    @station = Station.find(params[:id])
    @orders = Order.where(station_id: @station.id)
  end

  def create
    @station = Station.new(station_params)
    authorize @station
    @station.save!
    redirect_to station_path(@station.company_id)
  end

  def edit
    authorize @station
  end

  def update
    authorize @station
    @station.update(station_params)
    redirect_to station_path(@station.company_id)
  end

  def destroy
    authorize @station
    @station.destroy!
    redirect_to company_path(current_user)
  end

  private

  def station_params
    params.require(:station).permit(:name, :company_id)
  end

  def set_stations
    @station = Station.find(params[:id])
  end
end
