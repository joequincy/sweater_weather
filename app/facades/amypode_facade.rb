class AmypodeFacade
  def initialize(lat, lng)
    @lat = lat
    @lng = lng
  end

  def self.coordinates(lat, lng)
    f = new(lat, lng)
    [f.latitude, f.longitude]
  end

  private
  attr_reader :lat, :lng

  def results
    @_results ||= AmypodeService.results(lat, lng)
  end
end
