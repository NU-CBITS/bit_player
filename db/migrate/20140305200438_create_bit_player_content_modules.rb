class CreateBitPlayerContentModules < ActiveRecord::Migration
  def change
    create_table :bit_player_content_modules do |t|
      t.string :title, null: false
      t.string :context, null: false
      t.integer :position, null: false, default: 1

      t.timestamps
    end
  end
end
