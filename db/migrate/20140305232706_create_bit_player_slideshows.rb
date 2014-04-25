class CreateBitPlayerSlideshows < ActiveRecord::Migration
  def change
    create_table :bit_player_slideshows do |t|
      t.string :title, null: false

      t.timestamps
    end
  end
end
