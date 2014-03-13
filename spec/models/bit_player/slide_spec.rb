require "spec_helper"

describe BitPlayer::Slide do
  describe "#render_body" do
    let(:slide) { BitPlayer::Slide.new(body: "# header") }

    it "should render markdown as html" do
      expect(slide.render_body).to match(/<h1>header<\/h1>/)
    end
  end
end
