class FavoritesSerializer
  def initialize(locations)
    @output = locations.map do |location|
      {
        location: "#{location.city}, #{location.state}",
        current_weather: ForecastsSerializer.new(
                           location.forecast
                         ).serializable_hash
      }
    end
  end

  def to_json(*)
    @output.to_json
  end
end
