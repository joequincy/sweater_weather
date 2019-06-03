require 'rails_helper'

describe GoogleGeocoderService, type: :service do
  it 'returns data for the requested location' do
    g = GoogleGeocoderService.results('denver,+co')

    expect(g).to be_a(Hash)

    components = g[:results][0][:address_components].map do |c|
      c[:short_name].downcase
    end
    expect(components).to include('denver')
    expect(components).to include('co')

    geo_location = g[:results][0][:geometry][:location]
    expect(geo_location[:lat]).to be_within(0.5).of(39.7)
    expect(geo_location[:lng]).to be_within(0.5).of(-105.0)
  end
end
