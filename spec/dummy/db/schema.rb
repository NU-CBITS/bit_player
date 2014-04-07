# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140407201525) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bit_player_content_modules", force: true do |t|
    t.string   "title",                          null: false
    t.integer  "position",           default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bit_player_tool_id",             null: false
  end

  create_table "bit_player_content_providers", force: true do |t|
    t.string   "type",                                     null: false
    t.string   "source_content_type"
    t.integer  "source_content_id"
    t.integer  "bit_player_content_module_id",             null: false
    t.integer  "position",                     default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bit_player_content_providers", ["bit_player_content_module_id"], name: "content_module_index", using: :btree

  create_table "bit_player_participant_statuses", force: true do |t|
    t.string   "context"
    t.integer  "module_position"
    t.integer  "provider_position"
    t.integer  "content_position"
    t.integer  "participant_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bit_player_participant_statuses", ["participant_id"], name: "index_participant_statuses_on_participant_id", using: :btree

  create_table "bit_player_slides", force: true do |t|
    t.string   "title"
    t.text     "body",                                   null: false
    t.integer  "position",                default: 1,    null: false
    t.integer  "bit_player_slideshow_id",                null: false
    t.string   "type"
    t.text     "options"
    t.boolean  "is_title_visible",        default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bit_player_slides", ["bit_player_slideshow_id", "position"], name: "bit_player_slide_position", unique: true, using: :btree
  add_index "bit_player_slides", ["bit_player_slideshow_id"], name: "index_bit_player_slides_on_bit_player_slideshow_id", using: :btree

  create_table "bit_player_slideshows", force: true do |t|
    t.string   "title",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bit_player_tools", force: true do |t|
    t.string   "title",                      null: false
    t.integer  "position"
    t.boolean  "is_home",    default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bit_player_tools", ["position"], name: "index_bit_player_tools_on_position", unique: true, using: :btree
  add_index "bit_player_tools", ["title"], name: "index_bit_player_tools_on_title", unique: true, using: :btree

end
