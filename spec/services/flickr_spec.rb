require 'rails_helper'

describe FlickrService, type: :service do
  it 'returns photos for the requested location' do
    f = FlickrService.new
    photos = f.photos(39.704907, -104.927672)

    expect(photos).to be_a(Array)
    photos.each do |sample|
      expect(sample).to have_key(:url_o)
      expect(sample).to have_key(:height_o)
      expect(sample).to have_key(:width_o)
    end
  end
end
