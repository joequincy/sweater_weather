require 'json'

class AntipodesSerializer
  def initialize(location)
    @forecast = location.antipode_forecast
    @_output = {
      data: [
        {
          id: 1,
          type: "antipode",
          attributes: {
            location_name: location.address,
            forecast: {
              summary: @forecast.today[:summary],
              current_temperature: @forecast.today[:current]
            },
          },
          search_location: location.antipode
        }
      ]
    }
  end

  def to_json(*)
    @_output.to_json
  end
end
