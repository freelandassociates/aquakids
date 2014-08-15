# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140815203933) do

  create_table "activities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "attainments", :force => true do |t|
    t.date     "date_achieved"
    t.text     "comments"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "capacities", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "children", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "sex"
    t.date     "date_of_birth"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "parent_id"
    t.text     "notes"
  end

  create_table "days", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "facilities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "levels", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "parents", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "cell_phone"
    t.string   "home_phone"
    t.string   "work_phone"
    t.string   "care_provider"
    t.string   "care_provider_phone"
    t.text     "comments"
    t.string   "email"
    t.string   "alternate_email"
    t.string   "emergency_contact"
    t.string   "emergency_contact_phone"
    t.string   "insurance"
    t.string   "insurance_phone"
    t.string   "policy_number"
    t.string   "doctor"
    t.string   "doctor_phone"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "user_id"
    t.integer  "location_id"
  end

  create_table "programs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "registration_fee"
  end

  create_table "referrals", :force => true do |t|
    t.string   "referral_description"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "role"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "scheduleregs", :force => true do |t|
    t.text     "comments"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "location_id"
    t.integer  "schedule_id"
    t.integer  "child_id"
    t.string   "special"
    t.integer  "referral_id"
    t.string   "referred_by"
    t.date     "entry_date"
    t.date     "exit_date"
    t.integer  "skill_id"
    t.string   "continuance"
    t.date     "payment_due_date"
    t.integer  "level_id"
    t.string   "wait"
  end

  create_table "schedules", :force => true do |t|
    t.date     "start_date"
    t.date     "stop_date"
    t.integer  "day_of_week"
    t.time     "start_time"
    t.time     "stop_time"
    t.integer  "size"
    t.text     "comments"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "level_id"
    t.integer  "type_id"
    t.integer  "zone_id"
    t.integer  "activity_id"
    t.integer  "program_id"
    t.integer  "teacher_id"
    t.integer  "facility_id"
    t.integer  "location_id"
    t.boolean  "sunday"
    t.boolean  "monday"
    t.boolean  "tuesday"
    t.boolean  "wednesday"
    t.boolean  "thursday"
    t.boolean  "friday"
    t.boolean  "saturday"
    t.integer  "spaces"
    t.string   "capacity"
  end

  create_table "skills", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "level_id"
  end

  create_table "teachers", :force => true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "cell_phone"
    t.string   "home_phone"
    t.string   "work_phone"
    t.string   "email"
    t.text     "notes"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "location_id"
  end

  create_table "test_entities", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username"
    t.string   "role_id"
    t.integer  "location_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "zones", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
