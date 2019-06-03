class Api::V1::AntipodesController < Api::V1::BaseController
  def show
    location = Location.antipode(params[:location])
    render json: ForecastsSerializer.new(location.forecast)
  end
end
