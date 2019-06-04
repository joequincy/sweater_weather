require 'rails_helper'

describe 'api/v1/favorites' do
  let(:user) { User.create(email: 'whatever@example.com', password: 'password')}
  let(:headers) {
    {"ACCEPT" => "application/json",
     "CONTENT_TYPE" => "application/json"}
  }
  describe 'POST' do
    it 'adds a favorite city for a user' do
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

  describe 'GET' do
    it 'returns a list of the user\'s favorites with their forecasts' do
      denver = Location.query('Denver, CO')
      boulder = Location.query('Boulder, CO')
      user.favorites << denver
      user.favorites << boulder

      get '/api/v1/favorites',
          params: { api_key: user.api_key },
          headers: headers

      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body.first[:location]).to eq("Denver, CO")
      expect(body.first).to have_key(:current_weather)
      #format of current_weather TBD - for now assume same return as /forecast
      expect(body.first[:current_weather][:data][:attributes]).to have_key(:today)
      expect(body.first[:current_weather][:data][:attributes]).to have_key(:week)
    end

    it 'refuses to return favorites without an api key' do
      get '/api/v1/favorites',
          headers: headers

      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:unauthorized)

      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:error]).to eq("requires api key")
    end

    it 'refuses to return favorites with an invalid api key' do
      get '/api/v1/favorites',
          params: { api_key: "there is NO. RULE. SIX." },
          headers: headers

      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:unauthorized)

      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:error]).to eq("invalid api key")
    end
  end
end
