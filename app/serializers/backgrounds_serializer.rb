class BackgroundsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :height, :width, :url
end
