class ForecastsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :today, :week
end
