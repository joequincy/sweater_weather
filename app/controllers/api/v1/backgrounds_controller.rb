class Api::V1::BackgroundsController < Api::V1::BaseController
  def index
    location = Location.query(params[:location])
    render json: BackgroundsSerializer.new(location.backgrounds)
  end
end
