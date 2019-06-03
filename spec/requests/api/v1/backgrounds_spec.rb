require 'rails_helper'

describe 'api/v1/backgrounds' do
  it 'returns background image URL for the requested location' do
    headers = {
      "ACCEPT" => "application/json",
      "CONTENT_TYPE" => "application/json"
    }
    get '/api/v1/backgrounds', params: { location: 'denver,co' }, headers: headers

    expect(response.content_type).to eq('application/json')
    expect(response).to have_http_status(:ok)

    data = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
    # binding.pry
    expect(data).to have_key(:url)
  end
end
