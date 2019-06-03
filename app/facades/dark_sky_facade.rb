class DarkSkyFacade
  attr_reader :address

  def initialize(raw_data, address)
    @raw_data = raw_data
    @address = address
  end

  def self.new_forecast(lat, lng, address)
    new(service.forecast(lat,lng), address)
  end

  def id
    currently_raw[:time]
  end

  def today
    {
      current: currently_raw[:temperature],
      feels_like: currently_raw[:apparent_temperature],
      summary_now: currently_raw[:summary],
      icon_now: currently_raw[:icon],
      effective_time: currently_raw[:time],
      high: today_raw[:temperature_high],
      low: today_raw[:temperature_low],
      summary: today_raw[:summary],
      icon: today_raw[:icon],
      location: {lat: raw_data[:latitude], lng: raw_data[:longitude]},
      humidity: currently_raw[:humidity],
      visibility: currently_raw[:visibility],
      uv_index: currently_raw[:uv_index],
      hourly: hourly
    }
  end

  def week
    raw_data[:daily][:data].first(5).map do |day|
      {
        day_name: day[:time],
        icon: day[:icon],
        humidity: day[:humidity],
        high: day[:temperature_high],
        low: day[:temperature_low]
      }
    end
  end

  private
  attr_reader :raw_data

  def today_raw
    raw_data[:daily][:data].first
  end

  def currently_raw
    raw_data[:currently]
  end

  def hourly_raw
    raw_data[:hourly][:data]
  end

  def hourly
    hourly_raw.first(8).map do |hour|
      {
        time: hour[:time],
        icon: hour[:icon],
        temperature: hour[:temperature]
      }
    end
  end

  def self.service
    DarkSkyService.new
  end
end
