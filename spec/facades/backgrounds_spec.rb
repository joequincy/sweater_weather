require 'rails_helper'

describe BackgroundsFacade, type: :facade do
  it 'returns a list of background images for the region' do
    data = BackgroundsFacade.get_list(39.7, -105.0)

    expect(data).to be_a(Array)
    data.each do |image|
      expect(image).to respond_to(:url)
      expect(image.url).to_not be_empty
      expect(image).to respond_to(:height)
      expect(image.height).to_not be_empty
      expect(image).to respond_to(:width)
      expect(image.width).to_not be_empty
    end
  end
end
