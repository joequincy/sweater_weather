class Api::V1::FavoritesController < Api::V1::BaseController
  before_action :require_api_key

  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      city, state = params[:location].split(", ")
      location = Location.find_or_create_by(city: city, state: state)
      something = user.favorites << location
      render status: 201, json: { success: "#{params[:location]} added as favorite"}
    else
      render status: 401, json: { error: "invalid api key" }
    end
  end

  private

  def require_api_key
    render status: 401, json: { error: "requires api key" } unless params[:api_key]
  end
end
