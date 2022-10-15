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

ActiveRecord::Schema.define(version: 2022_10_15_193919) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.uuid "uid"
    t.string "email"
    t.string "full_name"
    t.string "role"
    t.string "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "task_state_logs", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.bigint "actor_id"
    t.bigint "owner_id"
    t.string "event"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "public_id", default: -> { "gen_random_uuid()" }
    t.index ["actor_id"], name: "index_task_state_logs_on_actor_id"
    t.index ["owner_id"], name: "index_task_state_logs_on_owner_id"
    t.index ["task_id"], name: "index_task_state_logs_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.bigint "creator_id", null: false
    t.bigint "owner_id", null: false
    t.boolean "active", default: true
    t.uuid "uid", default: -> { "gen_random_uuid()" }
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "jira_id"
    t.index ["creator_id"], name: "index_tasks_on_creator_id"
    t.index ["owner_id"], name: "index_tasks_on_owner_id"
  end

end
