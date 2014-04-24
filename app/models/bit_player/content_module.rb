module BitPlayer
  # A logical unit of content, possibly containing mixed provider types.
  class ContentModule < ActiveRecord::Base
    belongs_to :tool,
               class_name: "BitPlayer::Tool",
               foreign_key: :bit_player_tool_id
    has_many :content_providers,
             class_name: "BitPlayer::ContentProvider",
             foreign_key: :bit_player_content_module_id,
             inverse_of: :content_module,
             dependent: :destroy

    validates :title, :tool, :position, presence: true
    validates :position, numericality: { greater_than_or_equal_to: 1 }
    validates :position, uniqueness: { scope: :bit_player_tool_id }

    def provider(position)
      content_providers.where(position: position).first ||
        ContentProviders::Null.new(self, position)
    end

    def provider_exists?(position)
      content_providers.exists?(position: position)
    end

    def add_content_provider(type)
      content_providers.create(type: type, position: last_position + 1)
    end

    private

    def last_position
      content_providers.order(:position).last.try(:position) || 0
    end
  end
end
