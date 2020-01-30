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

ActiveRecord::Schema.define(version: 2020_01_23_160154) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "assignments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "referral_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["referral_id"], name: "index_assignments_on_referral_id"
    t.index ["user_id"], name: "index_assignments_on_user_id"
  end

  create_table "partners", force: :cascade do |t|
    t.boolean "accepting_referrals", default: true, null: false
    t.string "form_identifier"
    t.string "form_url", null: false
    t.string "name", null: false
    t.integer "max_monthly_referrals", null: false
    t.string "slug", null: false
    t.string "webhook_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_partners_on_slug"
    t.index ["webhook_token"], name: "index_partners_on_webhook_token"
  end

  create_table "referrals", force: :cascade do |t|
    t.bigint "partner_id"
    t.string "last_state", default: "review", null: false
    t.jsonb "original_response", default: {}, null: false
    t.integer "sequential_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["partner_id"], name: "index_referrals_on_partner_id"
    t.index ["sequential_id"], name: "index_referrals_on_sequential_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "referral_id"
    t.integer "position", null: false
    t.string "state", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["position"], name: "index_reviews_on_position"
    t.index ["referral_id"], name: "index_reviews_on_referral_id"
    t.index ["state"], name: "index_reviews_on_state"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "assignments", "referrals"
  add_foreign_key "assignments", "users"
  add_foreign_key "referrals", "partners"
  add_foreign_key "reviews", "referrals"
  add_foreign_key "reviews", "users"
end
