module BitPlayer
  class ContentProvider < ActiveRecord::Base
    belongs_to :bit_player_content_module
    belongs_to :source_content, polymorphic: true

    validates :bit_player_content_module, :position, presence: true
    validates_numericality_of :position, greater_than_or_equal_to: 1

    delegate :context, to: :bit_player_content_module, prefix: false

    def exists?(position)
      false
    end
  end
end
