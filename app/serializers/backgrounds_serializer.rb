class BackgroundsSerializer
  include FastJsonapi::ObjectSerializer
  attribute :height do |photo|
    photo.height_o
  end

  attribute :width do |photo|
    photo.width_o
  end

  attribute :url do |photo|
    photo.url_o
  end
end
