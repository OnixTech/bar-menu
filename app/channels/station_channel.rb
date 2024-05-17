class StationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "station_#{params[:room]}"
  end

  def unsubscribed
  end
end
