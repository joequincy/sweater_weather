class Location < ApplicationRecord
  before_create :populate_coords

  enum state: %i[AL AK AS AZ AR CA CO CT DE DC FL GA GU HI ID IL IN IA KS KY LA ME MD MH MA MI FM MN MS MO MT NE NV NH NJ NM NY NC ND MP OH OK OR PW PA PR RI SC SD TN TX UT VT VA VI WA WV WI WY]

  def self.query(location)
    city, state = location.upcase.split(",")
    find_or_create_by(city: city, state: state)
  end

  def forecast
    Rails.cache.fetch("#{city},#{state}",
                      expires_in: time_till_hour) do
      api
    end
  end

  private

  def api
    @_api ||= DarkSkyFacade.new_forecast(latitude, longitude)
  end

  def populate_coords
    self.latitude, self.longitude = GoogleGeocoderFacade.coordinates(city, state)
  end

  def time_till_hour
    t = Time.now
    (60 - t.min).minutes + (60 - t.sec).seconds
  end
end
