class Location < ApplicationRecord
  has_many :forecasts

  before_create :populate_coords!

  enum state: %i[AL AK AS AZ AR CA CO CT DE DC FL GA GU HI ID IL IN IA KS KY LA ME MD MH MA MI FM MN MS MO MT NE NV NH NJ NM NY NC ND MP OH OK OR PW PA PR RI SC SD TN TX UT VT VA VI WA WV WI WY]

  def self.query(location)
    set_callback :create, :before, :populate_coords!
    city, state = location.upcase.split(",")
    find_or_create_by(city: city, state: state)
  end

  def self.by_antipode(location)
    skip_callback :create, :before, :populate_coords!
    find_or_create_by(address: location)
  end

  def antipode_forecast
    antipode_coords!
    api
  end

  def forecast
    api
  end

  private

  def api
    @_api ||= DarkSkyFacade.new_forecast(latitude, longitude)
  end

  def populate_coords!
    self.latitude,
    self.longitude,
    self.address = GoogleGeocoderFacade.coordinates(city: city, state: state)
  end

  def antipode_coords!
    lat,
    lng,
    self.antipode = GoogleGeocoderFacade.coordinates(other: address)

    self.latitude,
    self.longitude = AmypodeFacade.coordinates(lat, lng)

    self.address = GoogleGeocoderFacade.antipode_name(latitude, longitude)
  end
end
