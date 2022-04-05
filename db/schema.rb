# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_04_04_195220) do
  create_table "firmwares", force: :cascade do |t|
    t.integer "node_type"
    t.integer "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nodes", force: :cascade do |t|
    t.string "chip_id"
    t.integer "node_type"
    t.integer "min_moisture"
    t.integer "max_moisture"
    t.integer "pump_id"
    t.boolean "open?", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "max_pumping_time", default: 30
    t.index ["chip_id"], name: "unique_chip_ids", unique: true
    t.index ["pump_id"], name: "index_nodes_on_pump_id"
  end

  create_table "records", force: :cascade do |t|
    t.integer "node_id", null: false
    t.integer "moisture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["node_id"], name: "index_records_on_node_id"
  end

  add_foreign_key "records", "nodes"
end
