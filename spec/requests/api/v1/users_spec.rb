require 'rails_helper'

describe 'api/v1/users' do
  it 'returns the api key for a new user' do
    headers = {
      "ACCEPT" => "application/json",
      "CONTENT_TYPE" => "application/json"
    }
    post '/api/v1/users',
         params: { email: "whatever@example.com",
                   password: "password",
                   password_confirmation: "password" }.to_json,
         headers: headers

    expect(response.content_type).to eq('application/json')
    expect(response).to have_http_status(:created)

    data = JSON.parse(response.body, symbolize_names: true)
    expect(data).to have_key(:api_key)
    expect(data[:api_key].length).to eq(64)
  end

  it 'rejects an attempt to add the same user a second time' do
    headers = {
      "ACCEPT" => "application/json",
      "CONTENT_TYPE" => "application/json"
    }
    params = { email: "whatever@example.com",
               password: "password",
               password_confirmation: "password" }.to_json

    post '/api/v1/users', params: params, headers: headers
    expect(response).to have_http_status(:created)

    post '/api/v1/users', params: params, headers: headers
    expect(response).to have_http_status(:conflict)

    data = JSON.parse(response.body, symbolize_names: true)
    expect(data).to have_key(:error)
    expect(data[:error]).to eq("email already exists")
  end
end
