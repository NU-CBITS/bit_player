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

ActiveRecord::Schema.define(version: 20140620222851) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bit_core_content_modules", force: :cascade do |t|
    t.string   "title",                        null: false
    t.integer  "position",         default: 1, null: false
    t.integer  "bit_core_tool_id",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["bit_core_tool_id", "position"], name: "bit_core_content_module_position", unique: true, using: :btree
  end

  create_table "bit_core_content_providers", force: :cascade do |t|
    t.string   "type",                                   null: false
    t.string   "source_content_type"
    t.integer  "source_content_id"
    t.integer  "bit_core_content_module_id",             null: false
    t.integer  "position",                   default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "template_path"
    t.string   "data_class_name"
    t.text     "data_attributes"
    t.boolean  "show_next_nav"
    t.text     "locals"
    t.index ["bit_core_content_module_id", "position"], name: "bit_core_content_provider_position", unique: true, using: :btree
  end

  create_table "bit_core_slides", force: :cascade do |t|
    t.string   "title",                                null: false
    t.text     "body",                                 null: false
    t.integer  "position",              default: 1,    null: false
    t.integer  "bit_core_slideshow_id",                null: false
    t.string   "type"
    t.boolean  "is_title_visible",      default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "options"
    t.index ["bit_core_slideshow_id", "position"], name: "bit_core_slide_position", unique: true, using: :btree
  end

  create_table "bit_core_slideshows", force: :cascade do |t|
    t.string   "title",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bit_core_tools", force: :cascade do |t|
    t.string   "title",                  null: false
    t.integer  "position",   default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["position"], name: "bit_core_tool_position", unique: true, using: :btree
  end

  create_table "bit_player_participant_statuses", force: :cascade do |t|
    t.string   "context"
    t.integer  "module_position"
    t.integer  "provider_position"
    t.integer  "content_position"
    t.integer  "participant_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["participant_id"], name: "index_participant_statuses_on_participant_id", using: :btree
  end

  add_foreign_key "bit_core_content_modules", "bit_core_tools", name: "fk_content_modules_tools"
  add_foreign_key "bit_core_content_providers", "bit_core_content_modules", name: "fk_content_providers_modules"
  add_foreign_key "bit_core_slides", "bit_core_slideshows", name: "fk_slideshows_slides"
end
