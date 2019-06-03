class FlickrService
  def photos(lat, lng)
    response = conn.get do |f|
      f.params['lat'] = lat
      f.params['lon'] = lng
    end
    json(response.body)
  end

  private

  def json(body)
    full_results = JSON.parse(body, symbolize_names: true)[:photos][:photo]
    full_results.select do |hash|
      hash[:url_o] != nil
    end
  end

  def conn
    Faraday.new('https://www.flickr.com/services/rest/') do |f|
      f.adapter Faraday.default_adapter
      f.params['api_key'] = ENV['FLICKR_KEY']
      f.params['method'] = 'flickr.photos.search'
      f.params['accuracy'] = 13
      f.params['safe_search'] = 1
      f.params['format'] = 'json'
      f.params['nojsoncallback'] = 1
      f.params['privacy_filter'] = 1
      f.params['tags'] = 'landscape,city,skyline,buildings'
      f.params['extras'] = 'url_o'
      f.params['content_type'] = 1
      f.params['privacy_filter'] = 1
      f.params['geo_context'] = 2
    end
  end
end
