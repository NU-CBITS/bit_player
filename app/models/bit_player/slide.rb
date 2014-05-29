require "redcarpet"

module BitPlayer
  # A page of "static" or presentational content (as opposed to data capture).
  class Slide < ActiveRecord::Base
    belongs_to :slideshow,
               class_name: "BitPlayer::Slideshow",
               foreign_key: :bit_player_slideshow_id,
               inverse_of: :slides

    validates :title, :body, :position, presence: true
    validates :position, numericality: { greater_than_or_equal_to: 1 }
    validates :position, uniqueness: { scope: :bit_player_slideshow_id }

    before_destroy :push_to_be_deleted_slide_to_end

    def self.update_positions(ids)
      transaction do
        connection.execute "SET CONSTRAINTS bit_player_slide_position DEFERRED"
        ids.each_with_index do |id, index|
          where(id: id).update_all(position: index + 1)
        end
      end
    end

    def render_body
      return "" if body.nil?

      Redcarpet::Markdown.new(
        Redcarpet::Render::HTML.new(
          filter_html: true,
          safe_links_only: true
        ),
        space_after_headers: true
      ).render(body).html_safe
    end

    protected

    def push_to_be_deleted_slide_to_end
      slideshow = self.slideshow
      slide_ids = slideshow.slide_ids
      slide_ids.delete(self.id)
      slide_ids.push(self.id)
      slideshow.slides.update_positions(slide_ids)
    end

  end
end
