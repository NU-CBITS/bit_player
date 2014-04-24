module BitPlayer
  # A section of an application.
  class Tool < ActiveRecord::Base
    has_many :content_modules,
             class_name: "BitPlayer::ContentModule",
             foreign_key: :bit_player_tool_id,
             inverse_of: :tool,
             dependent: :destroy
    validates :title, presence: true
    validates :position, uniqueness: true
    validates :is_home, inclusion: { in: [true, false] }

    def add_module(title)
      content_modules.create(title: title, position: last_position + 1)
    end

    private

    def last_position
      content_modules.order(:position).last.try(:position) || 0
    end
  end
end
