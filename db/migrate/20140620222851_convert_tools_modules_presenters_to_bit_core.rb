class BitPlayer::Tool < ActiveRecord::Base; end
class BitPlayer::ContentModule < ActiveRecord::Base; end
class BitPlayer::ContentProvider < ActiveRecord::Base; end

class ConvertToolsModulesPresentersToBitCore < ActiveRecord::Migration
  def up
    BitPlayer::Tool.all.each do |tool|
      BitCore::Tool.create!(
        title: tool.title,
        position: tool.position,
        is_home: tool.is_home
      )
    end
    BitPlayer::ContentModule.all.each do |mod|
      BitCore::ContentModule.create!(
        title: mod.title,
        bit_core_tool_id: mod.bit_player_tool_id,
        position: mod.position
      )
    end
    BitPlayer::ContentProvider.all.each do |pro|
      type = pro.type
      if type == "BitPlayer::ContentProviders::SlideshowProvider"
        type = "BitCore::ContentProviders::SlideshowProvider"
      end
      BitCore::ContentProvider.create!(
        type: type,
        source_content_type: pro.source_content_type,
        source_content_id: pro.source_content_id,
        bit_core_content_module_id: pro.bit_player_content_module_id,
        position: pro.position
      )
    end
    execute <<-SQL
      ALTER TABLE bit_player_content_modules
        DROP CONSTRAINT IF EXISTS fk_content_modules_tools
    SQL
    execute <<-SQL
      ALTER TABLE bit_player_content_providers
        DROP CONSTRAINT IF EXISTS fk_content_providers_modules
    SQL
    drop_table :bit_player_tools
    drop_table :bit_player_content_modules
    drop_table :bit_player_content_providers
  end
end
