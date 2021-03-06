require 'rails_helper'

describe 'api/v1/sessions' do
  it 'returns the api key for a signed-in user' do
    User.create!(email: 'whatever@example.com', password: 'password')
    headers = {
      "ACCEPT" => "application/json",
      "CONTENT_TYPE" => "application/json"
    }
    post '/api/v1/sessions',
         params: { email: "whatever@example.com",
                   password: "password" }.to_json,
         headers: headers

    expect(response.content_type).to eq('application/json')
    expect(response).to have_http_status(:ok)

    data = JSON.parse(response.body, symbolize_names: true)
    expect(data).to have_key(:api_key)
    expect(data[:api_key].length).to eq(64)
  end

  it 'rejects an invalid login attempt (password)' do
    User.create!(email: 'whatever@example.com', password: 'password')
    headers = {
      "ACCEPT" => "application/json",
      "CONTENT_TYPE" => "application/json"
    }
    post '/api/v1/sessions',
         params: { email: "whatever@example.com",
                   password: "wrongword" }.to_json,
         headers: headers

    expect(response.content_type).to eq('application/json')
    expect(response).to have_http_status(:unauthorized)

    data = JSON.parse(response.body, symbolize_names: true)
    expect(data).to have_key(:error)
    expect(data[:error]).to eq("invalid email or password")
  end

  it 'rejects an invalid login attempt (email)' do
    User.create!(email: 'whatever@example.com', password: 'password')
    headers = {
      "ACCEPT" => "application/json",
      "CONTENT_TYPE" => "application/json"
    }
    post '/api/v1/sessions',
         params: { email: "whyever@example.com",
                   password: "password" }.to_json,
         headers: headers

    expect(response.content_type).to eq('application/json')
    expect(response).to have_http_status(:unauthorized)

    data = JSON.parse(response.body, symbolize_names: true)
    expect(data).to have_key(:error)
    expect(data[:error]).to eq("invalid email or password")
  end
end
