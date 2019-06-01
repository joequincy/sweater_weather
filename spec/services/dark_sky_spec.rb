require 'rails_helper'

describe DarkSkyService, type: :service do
  it 'returns forecast for the requested location' do
    service = DarkSkyService.new

    data = service.forecast(39.704907, -104.927672)
    expect(data).to have_key(:currently)
    expect(data).to have_key(:minutely)
    expect(data).to have_key(:hourly)
    expect(data).to have_key(:daily)
    expect(data).to have_key(:flags)
  end

  it 'excludes unneeded data' do
    service = DarkSkyService.new('minutely,alerts')

    data = service.forecast(39.704907, -104.927672)
    expect(data).to have_key(:currently)
    expect(data).to_not have_key(:minutely)
    expect(data).to have_key(:hourly)
    expect(data).to have_key(:daily)
    expect(data).to_not have_key(:alerts)
  end
end
