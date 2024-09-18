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

ActiveRecord::Schema[7.0].define(version: 2024_09_16_151653) do
  create_table "applied_jobs", force: :cascade do |t|
    t.integer "job_id", null: false
    t.integer "user_id", null: false
    t.string "cover_letter"
    t.string "current_ctc"
    t.string "expected_ctc"
    t.string "contact_number"
    t.string "estimated_joining_within"
    t.boolean "serving_notice_period"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_applied_jobs_on_job_id"
    t.index ["user_id"], name: "index_applied_jobs_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "contact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "job_type"
    t.string "applicable_for"
    t.string "link_to_apply"
    t.string "salary_range"
    t.string "job_location"
    t.string "status"
    t.integer "total_positions"
    t.integer "posted_by_id"
    t.integer "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.index ["company_id"], name: "index_jobs_on_company_id"
  end

  create_table "notification_settings", force: :cascade do |t|
    t.boolean "on_new_job_post"
    t.boolean "on_removal_of_favourite_job"
    t.boolean "on_removal_of_existing_job"
    t.boolean "on_status_changed_on_applied_job"
    t.boolean "on_job_status_change"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notification_settings_on_user_id"
  end

  create_table "user_saved_jobs", force: :cascade do |t|
    t.integer "job_id", null: false
    t.integer "user_id", null: false
    t.datetime "removed_from_favourite_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_user_saved_jobs_on_job_id"
    t.index ["user_id"], name: "index_user_saved_jobs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "first_name"
    t.string "last_name"
    t.string "role"
    t.string "contact_number"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "applied_jobs", "jobs"
  add_foreign_key "applied_jobs", "users"
  add_foreign_key "jobs", "companies"
  add_foreign_key "notification_settings", "users"
  add_foreign_key "user_saved_jobs", "jobs"
  add_foreign_key "user_saved_jobs", "users"
end
