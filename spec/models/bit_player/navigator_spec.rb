require "spec_helper"

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

  it "should render the content from the current provider" do
    nav = BitPlayer::Navigator.new(participant)
    expect(nav.render_current_content(view_context)).to match(/Oops/)
  end
end
