class BitPlayer::Slideshow < ActiveRecord::Base; end
class BitPlayer::Slide < ActiveRecord::Base; end

class ConvertSlidesSlideshowsToBitCore < ActiveRecord::Migration
  def up
    BitPlayer::Slideshow.all.each do |slideshow|
      BitCore::Slideshow.create!(title: slideshow.title, id: slideshow.id)
    end
    BitPlayer::Slide.all.each do |slide|
      BitCore::Slide.create!(
        title: slide.title,
        id: slide.id,
        body: slide.body,
        position: slide.position,
        bit_core_slideshow_id: bit_player_slideshow_id,
        type: slide.type,
        options: slide.options,
        is_title_visible: slide.is_title_visible
      )
    end
    execute <<-SQL
      ALTER TABLE bit_player_slides
        DROP CONSTRAINT fk_slides_slideshows
    SQL

    execute <<-SQL
      ALTER TABLE bit_player_slides
        DROP CONSTRAINT IF EXISTS bit_player_slide_position
    SQL
    drop_table :bit_player_slides
    drop_table :bit_player_slideshows
  end
end
