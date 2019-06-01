class DarkSkyService
  def initialize(exclusions = nil)
    @exclusions = exclusions
  end

  def forecast(lat, lng)
    json(forecast_api.get("#{lat},#{lng}/#{query}"))
  end

  private
  attr_reader :exclusions

  def query
    exclusions ? "?exclude=#{exclusions}" : ''
  end

  def json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def forecast_api
    Faraday.new("https://api.darksky.net/forecast/#{ENV['DARKSKY_API_KEY']}/")
  end
end
