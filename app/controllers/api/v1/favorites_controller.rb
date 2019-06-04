class Api::V1::FavoritesController < Api::V1::BaseController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      city, state = params[:location].split(", ")
      location = Location.find_or_create_by(city: city, state: state)
      something = user.favorites << location
      render status: 200
    else
      render status: 401, json: { error: "invalid api key" }
    end
  end
end
