require 'rails_helper'

describe 'api/v1/backgrounds' do
  it 'returns 5 background images with URLs for the requested location' do
    headers = {
      "ACCEPT" => "application/json",
      "CONTENT_TYPE" => "application/json"
    }
    get '/api/v1/backgrounds', params: { location: 'denver,co' }, headers: headers

    expect(response.content_type).to eq('application/json')
    expect(response).to have_http_status(:ok)

    data = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(data.count).to eq(5)

    sample = data.first[:attributes]
    expect(sample).to have_key(:url)
    expect(sample).to have_key(:height)
    expect(sample).to have_key(:width)
  end
end
