module BitPlayer
  # A collection of ordered Slides.
  class Slideshow < ActiveRecord::Base
    has_many :slides,
             -> { order "position" },
             class_name: "BitPlayer::Slide",
             foreign_key: :bit_player_slideshow_id,
             dependent: :destroy,
             inverse_of: :slideshow
    has_one :content_provider,
            as: :source_content,
            inverse_of: :source_content,
            dependent: :nullify

    validates :title, presence: true

    accepts_nested_attributes_for :slides
  end
end
