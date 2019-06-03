class Api::V1::AntipodesController < Api::V1::BaseController
  def show
    location = Location.by_antipode(params[:loc])
    render json: ForecastsSerializer.new(location.forecast)
  end
end
