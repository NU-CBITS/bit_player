class AddConfigFieldsToProviders < ActiveRecord::Migration
  def change
    add_column :bit_player_content_providers, :template_path, :string
    add_column :bit_player_content_providers, :data_class_name, :string
    add_column :bit_player_content_providers, :data_attributes, :text
    add_column :bit_player_content_providers, :show_next_nav, :boolean
    add_column :bit_player_content_providers, :locals, :text
  end
end
