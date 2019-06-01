class Api::V1::ForecastsController < Api::V1::BaseController
  def show
    location = Location.query(params[:location])
    render json: ForecastsSerializer.new(location.forecast)
  end
end
