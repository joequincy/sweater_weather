class GoogleGeocoderFacade
  def initialize(city, state)
    @city = city
    @state = state
  end

  def self.coordinates(city, state)
    f = new(city, state)
    [f.latitude, f.longitude]
  end

  def latitude
    results[:results][0][:geometry][:location][:lat]
  end

  def longitude
    results[:results][0][:geometry][:location][:lng]
  end

  private
  attr_reader :city, :state

  def results
    @_results ||= GoogleGeocoderService.results(city, state)
  end
end
