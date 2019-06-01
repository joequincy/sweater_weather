require 'rails_helper'

describe 'api/v1/forecasts' do
  it 'returns forecast for the requested location' do
    headers = {
      "ACCEPT" => "application/json",
      "CONTENT_TYPE" => "application/json"
    }
    get '/api/v1/forecast', params: { location: 'denver,co' }, headers: headers

    expect(response.content_type).to eq('application/json')
    expect(response).to have_http_status(:ok)

    data = JSON.parse(response.body, symbolize_names: true)
    expect(data).to have_key(:today)
    expect(data).to have_key(:week)

    today = data[:today]
    expect(today).to have_key(:current)
    expect(today).to have_key(:high)
    expect(today).to have_key(:low)
    expect(today).to have_key(:feels_like)
    expect(today).to have_key(:sky)
    expect(today).to have_key(:location)
    expect(today).to have_key(:effective_time)
    expect(today).to have_key(:description_today)
    expect(today).to have_key(:description_tonight)
    expect(today).to have_key(:humidity)
    expect(today).to have_key(:visibility)
    expect(today).to have_key(:uv_index)
    expect(today).to have_key(:hourly)

    expect(today[:hourly]).to be_instance_of(Array)
    hourly = today[:hourly].first

    expect(hourly).to have_key(:sky)
    expect(hourly).to have_key(:temperature)

    week = data[:forecast]
    expect(week).to have_key(:day)
    expect(week).to have_key(:sky)
    expect(week).to have_key(:humidity)
    expect(week).to have_key(:high)
    expect(week).to have_key(:low)
  end
end
