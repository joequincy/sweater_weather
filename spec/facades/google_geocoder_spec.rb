require 'rails_helper'

describe GoogleGeocoderFacade, type: :facade do
  it 'calculates lat/lng for the requested location' do
    g = GoogleGeocoderFacade.new('denver', 'co')

    expect(g.latitude).to be_within(0.5).of(39.7)
    expect(g.longitude).to be_within(0.5).of(-105.0)
  end

  it 'returns lat/lng in an array' do
    g = GoogleGeocoderFacade.coordinates('denver', 'co')

    expect(g[0]).to be_within(0.5).of(39.7)
    expect(g[1]).to be_within(0.5).of(-105.0)
  end
end
