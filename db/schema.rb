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

ActiveRecord::Schema.define(version: 2018_10_01_202641) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "partners", force: :cascade do |t|
    t.boolean "accepting_referrals", default: true, null: false
    t.string "form_url", null: false
    t.string "form_identifier"
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
    t.index ["position"], name: "index_reviews_on_position"
    t.index ["referral_id"], name: "index_reviews_on_referral_id"
    t.index ["state"], name: "index_reviews_on_state"
  end

  add_foreign_key "referrals", "partners"
  add_foreign_key "reviews", "referrals"
end
