require 'rails_helper'

describe 'api/v1/antipode' do
  it 'returns forecast for the antipode of the requested location' do
    headers = {
      "ACCEPT" => "application/json",
      "CONTENT_TYPE" => "application/json"
    }
    get '/api/v1/antipode', params: { loc: 'hongkong' }, headers: headers

    expect(response.content_type).to eq('application/json')
    expect(response).to have_http_status(:ok)

    data = JSON.parse(response.body, symbolize_names: true)[:data].first

    expect(data).to have_key(:search_location)
    expect(data[:search_location]).to eq("Hong Kong")

    attributes = data[:attributes]
    expect(attributes).to have_key(:location_name)
    expect(attributes).to have_key(:forecast)
    expect(attributes[:location_name]).to eq("Yavi Department, Jujuy, Argentina")

    forecast = attributes[:forecast]
    expect(forecast).to have_key(:summary)
    expect(forecast).to have_key(:current_temperature)
  end
end
