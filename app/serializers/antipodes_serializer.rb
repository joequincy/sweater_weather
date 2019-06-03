class AntipodesSerializer
  include FastJsonapi::ObjectSerializer
  attribute :location_name do |location|
    location.address
  end

  attribute :forecast do |api|
    {
      summary: api.today[:summary],
      current_temperature: api.today[:current]
    }
  end
end
