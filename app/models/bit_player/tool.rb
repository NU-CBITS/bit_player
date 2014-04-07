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
  end
end
