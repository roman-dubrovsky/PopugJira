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

ActiveRecord::Schema.define(version: 2022_10_20_231059) do

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

  create_table "balances", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "billing_cycle_id", null: false
    t.integer "debit_cents", default: 0, null: false
    t.string "debit_currency", default: "USD", null: false
    t.integer "credit_cents", default: 0, null: false
    t.string "credit_currency", default: "USD", null: false
    t.string "title"
    t.uuid "uid", default: -> { "gen_random_uuid()" }
    t.string "metadata"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "source"
    t.index ["account_id"], name: "index_balances_on_account_id"
    t.index ["billing_cycle_id"], name: "index_balances_on_billing_cycle_id"
  end

  create_table "billing_cycles", force: :cascade do |t|
    t.uuid "uid", default: -> { "gen_random_uuid()" }
    t.date "date"
    t.string "title"
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.uuid "uid"
    t.string "title"
    t.integer "assign_price_cents", default: 0, null: false
    t.string "assign_price_currency", default: "USD", null: false
    t.integer "complete_price_cents", default: 0, null: false
    t.string "complete_price_currency", default: "USD", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "owner_id"
    t.index ["owner_id"], name: "index_tasks_on_owner_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "billing_cycle_id", null: false
    t.bigint "task_id"
    t.integer "debit_cents", default: 0, null: false
    t.string "debit_currency", default: "USD", null: false
    t.integer "credit_cents", default: 0, null: false
    t.string "credit_currency", default: "USD", null: false
    t.uuid "uid", default: -> { "gen_random_uuid()" }
    t.string "kind"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["billing_cycle_id"], name: "index_transactions_on_billing_cycle_id"
    t.index ["task_id"], name: "index_transactions_on_task_id"
  end

end
