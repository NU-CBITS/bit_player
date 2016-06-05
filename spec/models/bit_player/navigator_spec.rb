# frozen_string_literal: true
require "spec_helper"
require "bit_core"

describe BitPlayer::Navigator do
  let(:arm) { double("arm") }
  let(:group) { double("group", arm: arm) }
  let(:provider) { double("provider") }

  describe "#render_current_content" do
    let(:status) do
      double(
        "status",
        context: "a",
        module_position: 1,
        provider_position: 2,
        content_position: 3
      )
    end
    let(:participant) do
      double("participant", navigation_status: status, active_group: group)
    end
    let(:view_context) { double("context", current_participant: participant) }
    let(:nav) { BitPlayer::Navigator.new(participant) }

    before do
      allow(arm).to receive_message_chain(:bit_core_tools, :find_by_title)
        .and_return(double("tool", id: 1))
    end

    it "should render the content from the current provider" do
      expect(nav.render_current_content(view_context)).to match(/Oops/)
    end
  end

  describe "#fetch_next_content" do
    let(:status) do
      double(
        "status",
        context: "a",
        module_position: 1,
        provider_position: nil,
        content_position: nil
      )
    end
    let(:participant) do
      double("participant", navigation_status: status, active_group: group)
    end
    let(:view_context) { double("context", current_participant: participant) }
    let(:nav) { BitPlayer::Navigator.new(participant) }

    before do
      allow(arm).to receive_message_chain(:bit_core_tools, :find_by_title)
        .and_return(double("tool", id: 1))
    end

    it "should initialize context if content_position and "\
       "provider_position is nil" do
      expect(status).to receive(:initialize_context)
      nav.fetch_next_content
    end
  end
end
