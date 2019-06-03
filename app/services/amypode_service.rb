class AmypodeService
  def self.results(lat, lng)
    response = amypode_api.get do |g|
      g.params['lat'] = lat
      g.params['long'] = lng
    end
    json(response)
  end

  private

  def self.json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.amypode_api
    Faraday.new('http://amypode.herokuapp.com/api/v1/antipodes') do |f|
      f.adapter Faraday.default_adapter
      f.headers['api_key'] = ENV['AMYPODE_KEY']
    end
  end
end
