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

    data = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
    # binding.pry
    expect(data).to have_key(:today)
    expect(data).to have_key(:week)

    today = data[:today]
    expect(today).to have_key(:current)
    expect(today).to have_key(:high)
    expect(today).to have_key(:low)
    expect(today).to have_key(:feels_like)
    expect(today).to have_key(:icon)
    expect(today).to have_key(:icon_now)
    expect(today).to have_key(:location)
    expect(today).to have_key(:effective_time)
    expect(today).to have_key(:summary)
    expect(today).to have_key(:summary_now)
    expect(today).to have_key(:humidity)
    expect(today).to have_key(:visibility)
    expect(today).to have_key(:uv_index)
    expect(today).to have_key(:hourly)

    expect(today[:hourly]).to be_a(Array)
    hourly = today[:hourly].first

    expect(hourly).to have_key(:time)
    expect(hourly).to have_key(:icon)
    expect(hourly).to have_key(:temperature)

    expect(data[:week]).to be_a(Array)
    expect(data[:week].count).to eq(5)
    day = data[:week].first

    expect(day).to have_key(:day_name)
    expect(day).to have_key(:icon)
    expect(day).to have_key(:humidity)
    expect(day).to have_key(:high)
    expect(day).to have_key(:low)
  end
end
