require "spec_helper"

describe BitPlayer::Slide do
  describe "#render_body" do
    let(:slide) { BitPlayer::Slide.new }

    it "should render a nil body" do
      expect(slide.render_body).to eq("")
    end

    it "should render markdown as html" do
      slide.body = "# header"

      expect(slide.render_body).to match(/<h1>header<\/h1>/)
    end
  end
end
