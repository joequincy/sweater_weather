require 'rails_helper'

describe AmypodeService, type: :service do
  it 'returns coordinates for the opposite side of the globe from a requested location' do
    lat = 27
    lng = -82
    a = AmypodeService.results(lat,lng)

    expect(a).to be_a(Hash)

    coordinates = a[:data][:attributes]
    expect(coordinates[:lat]).to eq(-lat)
    expect(coordinates[:long]).to eq((lng + 180) + 360 * (lng > 0 ? -1 : 0))
  end
end
