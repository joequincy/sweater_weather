class GoogleGeocoderFacade
  def initialize(city: nil, state: nil, other: nil)
    @city = city
    @state = state
    @other = other.gsub(' ', '+') if other
  end

  def self.coordinates(**args)
    f = new(**args)
    [f.latitude, f.longitude]
  end

  def latitude
    results[:results][0][:geometry][:location][:lat]
  end

  def longitude
    results[:results][0][:geometry][:location][:lng]
  end

  private
  attr_reader :city, :state, :other

  def results
    @_results ||= GoogleGeocoderService.results([city, state, other].compact.join(','))
  end
end
