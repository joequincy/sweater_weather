class GoogleGeocoderService
  def self.results(address)
    response = geocoder_api.get do |g|
      g.params['address'] = address
    end
    json(response)
  end

  private

  def self.json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.geocoder_api
    Faraday.new('https://maps.googleapis.com/maps/api/geocode/json') do |f|
      f.adapter Faraday.default_adapter
      f.params['key'] = ENV['GOOGLE_API_KEY']
    end
  end
end
