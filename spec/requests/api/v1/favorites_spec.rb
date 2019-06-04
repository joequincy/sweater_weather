require 'rails_helper'

describe 'api/v1/favorites' do
  it 'adds a favorite city for a user' do
    user = User.create(email: 'whatever@example.com', password: 'password')
    headers = {
      "ACCEPT" => "application/json",
      "CONTENT_TYPE" => "application/json"
    }
    post '/api/v1/favorites',
         params: { location: "Denver, CO",
                   api_key: user.api_key }.to_json,
         headers: headers

    expect(response.content_type).to eq('application/json')
    expect(response).to have_http_status(:created)

    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:success]).to eq("Denver, CO added as favorite")

    user.reload
    denver = Location.find_by(city: "Denver", state: "CO")
    expect(user.favorites).to include(denver)
  end

  it 'refuses to add a favorite city without an api key' do
    user = User.create(email: 'whatever@example.com', password: 'password')
    headers = {
      "ACCEPT" => "application/json",
      "CONTENT_TYPE" => "application/json"
    }
    post '/api/v1/favorites',
         params: { location: "Denver, CO" }.to_json,
         headers: headers

    expect(response.content_type).to eq('application/json')
    expect(response).to have_http_status(:unauthorized)

    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:error]).to eq("requires api key")

    denver = Location.find_by(city: "Denver", state: "CO")
    expect(denver).to be_nil
  end

  it 'refuses to add a favorite city with an invalid api key' do
    user = User.create(email: 'whatever@example.com', password: 'password')
    headers = {
      "ACCEPT" => "application/json",
      "CONTENT_TYPE" => "application/json"
    }
    post '/api/v1/favorites',
         params: { location: "Denver, CO",
                   api_key: "there is NO. RULE. SIX." }.to_json,
         headers: headers

    expect(response.content_type).to eq('application/json')
    expect(response).to have_http_status(:unauthorized)

    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:error]).to eq("invalid api key")

    denver = Location.find_by(city: "Denver", state: "CO")
    expect(denver).to be_nil
  end
end
