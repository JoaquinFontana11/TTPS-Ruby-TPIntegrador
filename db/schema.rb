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
    t.string "name"
    t.string "direc"
    t.string "tel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "schedule_id"
    t.index ["schedule_id"], name: "index_branch_offices_on_schedule_id", unique: true
  end

  create_table "schedules", force: :cascade do |t|
    t.time "mondayInit"
    t.time "mondayFinish"
    t.time "tuesdayInit"
    t.time "tuesdayFinish"
    t.time "wednesdayInit"
    t.time "wednesdayFinish"
    t.time "thursdayInit"
    t.time "thursdayFinish"
    t.time "fridayInit"
    t.time "fridayFinish"
    t.time "saturdayInit"
    t.time "saturdayFinish"
    t.time "sundayInit"
    t.time "sundayFinish"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "branch_office_id"
    t.index ["branch_office_id"], name: "index_schedules_on_branch_office_id", unique: true
  end

  create_table "turns", force: :cascade do |t|
    t.date "date"
    t.time "hour"
    t.integer "state"
    t.string "reason"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "branch_office_id"
    t.bigint "patient_id"
    t.bigint "staff_attended_id"
    t.index ["branch_office_id"], name: "index_turns_on_branch_office_id"
    t.index ["patient_id"], name: "index_turns_on_patient_id", unique: true
    t.index ["staff_attended_id"], name: "index_turns_on_staff_attended_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "branch_office_id"
    t.index ["branch_office_id"], name: "index_users_on_branch_office_id"
  end

  add_foreign_key "branch_offices", "schedules"
  add_foreign_key "schedules", "branch_offices"
  add_foreign_key "turns", "branch_offices"
  add_foreign_key "turns", "users", column: "patient_id"
  add_foreign_key "turns", "users", column: "staff_attended_id"
  add_foreign_key "users", "branch_offices"
end
