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

ActiveRecord::Schema[7.0].define(version: 2022_11_30_185215) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "branch_offices", force: :cascade do |t|
    t.string "name", null: false
    t.string "direc", null: false
    t.string "tel", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "schedule_id", null: false
    t.index ["schedule_id"], name: "index_branch_offices_on_schedule_id", unique: true
  end

  create_table "schedules", force: :cascade do |t|
    t.time "mondayInit", null: false
    t.time "mondayFinish", null: false
    t.time "tuesdayInit", null: false
    t.time "tuesdayFinish", null: false
    t.time "wednesdayInit", null: false
    t.time "wednesdayFinish", null: false
    t.time "thursdayInit", null: false
    t.time "thursdayFinish", null: false
    t.time "fridayInit", null: false
    t.time "fridayFinish", null: false
    t.time "saturdayInit", null: false
    t.time "saturdayFinish", null: false
    t.time "sundayInit", null: false
    t.time "sundayFinish", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "turns", force: :cascade do |t|
    t.date "date", null: false
    t.time "hour", null: false
    t.integer "state", null: false
    t.string "reason", null: false
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "branch_office_id", null: false
    t.bigint "client_id", null: false
    t.bigint "staff_attended_id"
    t.index ["branch_office_id"], name: "index_turns_on_branch_office_id"
    t.index ["client_id"], name: "index_turns_on_client_id"
    t.index ["staff_attended_id"], name: "index_turns_on_staff_attended_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "password_digest", null: false
    t.string "role", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "branch_office_id"
    t.index ["branch_office_id"], name: "index_users_on_branch_office_id"
  end

  add_foreign_key "branch_offices", "schedules"
  add_foreign_key "turns", "branch_offices"
  add_foreign_key "turns", "users", column: "client_id"
  add_foreign_key "turns", "users", column: "staff_attended_id"
  add_foreign_key "users", "branch_offices"
end
