require "spec_helper"

describe BitPlayer::ContentModule do
  fixtures :"bit_player/content_modules", :"bit_player/content_providers"

  describe "#provider" do
    it "should return the Null Provider when one is not found" do
      provider = bit_player_content_modules(:home_landing).provider(8)
      expect(provider.position).to eq(8)
      expect(provider.class).to eq(BitPlayer::ContentProviders::Null)
    end

    it "should return the associated provider at the position" do
      provider = bit_player_content_modules(:home_landing).provider(1)
      expect(provider.position).to eq(1)
      expect(provider.class).not_to eq(BitPlayer::ContentProviders::Null)
    end
  end
end
