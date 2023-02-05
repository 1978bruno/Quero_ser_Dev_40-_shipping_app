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

ActiveRecord::Schema[7.0].define(version: 2023_02_05_114453) do
  create_table "costs", force: :cascade do |t|
    t.integer "int_min_weight"
    t.integer "int_max_weight"
    t.integer "km_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shipping_id", null: false
    t.index ["shipping_id"], name: "index_costs_on_shipping_id"
  end

  create_table "deliv_terms", force: :cascade do |t|
    t.integer "term_int_min_weight"
    t.integer "term_int_max_weight"
    t.integer "deliv_term"
    t.integer "shipping_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shipping_id"], name: "index_deliv_terms_on_shipping_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "code"
    t.string "collect_street"
    t.integer "collect_number"
    t.string "collect_nhood"
    t.string "collect_city"
    t.string "collect_state"
    t.integer "width"
    t.integer "height"
    t.integer "depth"
    t.integer "weight"
    t.string "deliv_reipient"
    t.string "deliv_street"
    t.integer "deliv_number"
    t.string "deliv_nhood"
    t.string "deliv_city"
    t.string "deliv_state"
    t.integer "km_dist"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "deliv_zip"
    t.integer "collect_zip"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "shippings", force: :cascade do |t|
    t.string "name"
    t.integer "min_dist"
    t.integer "max_dist"
    t.integer "min_weight"
    t.integer "max_weight"
    t.integer "deliv_fee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicle_categories", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicle_types", force: :cascade do |t|
    t.string "manufacturer_vehicle"
    t.string "model_vehicle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "license_plate"
    t.integer "vehicle_types_id", null: false
    t.integer "vehicle_categories_id", null: false
    t.integer "manufature_year"
    t.integer "maximum_load_capacity"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vehicle_categories_id"], name: "index_vehicles_on_vehicle_categories_id"
    t.index ["vehicle_types_id"], name: "index_vehicles_on_vehicle_types_id"
  end

  add_foreign_key "costs", "shippings"
  add_foreign_key "deliv_terms", "shippings"
  add_foreign_key "orders", "users"
  add_foreign_key "vehicles", "vehicle_categories", column: "vehicle_categories_id"
  add_foreign_key "vehicles", "vehicle_types", column: "vehicle_types_id"
end
