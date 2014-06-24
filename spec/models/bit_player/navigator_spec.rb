require "spec_helper"
require "bit_core"

describe BitPlayer::Navigator do
  let(:status) do
    double(
      "status",
      context: "a",
      module_position: 1,
      provider_position: 2,
      content_position: 3
    )
  end
  let(:participant) { double("participant", navigation_status: status) }
  let(:view_context) { double("context", current_participant: participant) }
  let(:provider) { double("provider") }
  let(:nav) { BitPlayer::Navigator.new(participant) }

  before do
    expect(BitCore::Tool).to receive(:find_by_title)
      .and_return(double("tool", id: 1))
  end

  describe "#render_current_content" do
    it "should render the content from the current provider" do
      expect(nav.render_current_content(view_context)).to match(/Oops/)
    end
  end
end
