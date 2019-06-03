require 'rails_helper'

describe DarkSkyFacade, type: :facade do
  it 'returns coordinates for the antipode of the requested location' do
    data = AmypodeFacade.coordinates(27, -82)

    expect(data).to be_a(Array)
    expect(data[0]).to eq(-27)
    expect(data[1]).to eq(98)
  end
end
