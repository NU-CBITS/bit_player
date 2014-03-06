module BitPlayer
  class ContentProvider < ActiveRecord::Base
    belongs_to :content_module,
      class_name: 'BitPlayer::ContentModule',
      foreign_key: :bit_player_content_module_id,
      inverse_of: :content_providers
    belongs_to :source_content, polymorphic: true

    validates :content_module, :position, presence: true
    validates_numericality_of :position, greater_than_or_equal_to: 1

    delegate :context, to: :content_module, prefix: false

    def exists?(position)
      false
    end
  end
end
