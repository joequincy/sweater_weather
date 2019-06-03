class BackgroundsFacade
  attr_reader :id, :url, :height, :width

  def initialize(photo)
    @id = photo[:id]
    @url = photo[:url_o]
    @height = photo[:height_o]
    @width = photo[:width_o]
  end

  def self.get_list(lat, lng)
    service.photos(lat, lng).map do |photo|
      BackgroundsFacade.new(photo)
    end
  end

  private

  def self.service
    FlickrService.new
  end
end
