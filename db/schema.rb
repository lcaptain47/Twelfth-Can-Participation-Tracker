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

ActiveRecord::Schema.define(version: 2021_03_29_214615) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description"
    t.integer "volunteers"
    t.integer "front_desks"
    t.integer "runners"
  end

  create_table "timeslots", force: :cascade do |t|
    t.time "time"
    t.integer "duration"
    t.boolean "is_approved"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "event_id"
    t.integer "user_id"
    t.string "role"
    t.integer "role_number"
  end

  create_table "user_roles", force: :cascade do |t|
    t.string "name"
    t.boolean "can_create"
    t.boolean "can_delete"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "can_delete_users"
    t.boolean "can_promote_demote"
    t.boolean "can_claim_unclaim"
    t.boolean "can_approve_unapprove"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "full_name"
    t.string "uid"
    t.string "avatar_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_role_id"
    t.float "total_approved_hours"
    t.float "total_unapproved_hours"
    t.float "front_office_hours"
    t.float "pantry_runner_hours"
    t.float "volunteer_hours"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
