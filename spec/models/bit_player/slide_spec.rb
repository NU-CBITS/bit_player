require "spec_helper"

describe BitPlayer::Slide do
  fixtures :"bit_player/slideshows", :"bit_player/slides"

  describe ".update_positions" do
    it "should update slide positions to match the order of the ids" do
      slide1 = bit_player_slides(:slide1)
      slide2 = bit_player_slides(:slide2)
      slide3 = bit_player_slides(:slide3)
      BitPlayer::Slide.update_positions([slide3.id, slide1.id, slide2.id])

      expect(BitPlayer::Slide.find(slide1.id).position).to eq(2)
      expect(BitPlayer::Slide.find(slide2.id).position).to eq(3)
      expect(BitPlayer::Slide.find(slide3.id).position).to eq(1)
    end
  end

  describe "#render_body" do
    let(:slide) { BitPlayer::Slide.new }

    it "should render a nil body" do
      expect(slide.render_body).to eq("")
    end

    it "should render markdown as html" do
      slide.body = "# header"

      expect(slide.render_body).to match(/<h1>header<\/h1>/)
    end

    it "should escape html" do
      slide.body = "<div>my content</div>"

      expect(slide.render_body).to match(/<p>my content<\/p>/)
    end
  end
end
