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

ActiveRecord::Schema.define(version: 2022_01_04_161755) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "expenses", force: :cascade do |t|
    t.string "name"
    t.integer "amount"
    t.datetime "date"
    t.text "memo"
    t.integer "expense_type"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.string "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.text "memo"
    t.bigint "user_id", null: false
    t.bigint "work_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_schedules_on_user_id"
    t.index ["work_id"], name: "index_schedules_on_work_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "works", force: :cascade do |t|
    t.string "name"
    t.integer "wage"
    t.integer "wage_type"
    t.integer "carfare", default: 0
    t.integer "carfare_type"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_works_on_user_id"
  end

  add_foreign_key "expenses", "users"
  add_foreign_key "schedules", "users"
  add_foreign_key "schedules", "works"
  add_foreign_key "works", "users"
end
