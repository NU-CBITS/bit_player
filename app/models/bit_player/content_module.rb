module BitPlayer
  # A logical unit of content, possibly containing mixed provider types.
  class ContentModule < ActiveRecord::Base
    has_many :content_providers,
             class_name: "BitPlayer::ContentProvider",
             foreign_key: :bit_player_content_module_id,
             inverse_of: :content_module

    validates :title, :context, :position, presence: true
    validates :position, numericality: { greater_than_or_equal_to: 1 }
    validates :position, uniqueness: { scope: :context }

    def provider(position)
      content_providers.where(position: position).first ||
        BitPlayer::ContentProviders::Null.new(self, position)
    end

    def provider_exists?(position)
      content_providers.exists?(position: position)
    end
  end
end
