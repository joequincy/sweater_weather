require 'rails_helper'

describe DarkSkyFacade, type: :facade do
  it 'returns forecast for the requested location' do
    data = DarkSkyFacade.new_forecast(39.7, -105.0)

    expect(data).to be_a(DarkSkyFacade)
    expect(data).to respond_to(:today)
    expect(data).to respond_to(:week)
  end
end
