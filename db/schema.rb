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

ActiveRecord::Schema.define(:version => 20111212233024) do

  create_table "analyses", :force => true do |t|
    t.string   "content"
    t.integer  "kind"
    t.integer  "user_id"
    t.integer  "swot_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "areas", :force => true do |t|
    t.string   "name"
    t.integer  "company_id"
    t.boolean  "is_root_area"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attachments", :force => true do |t|
    t.string   "content"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.integer  "operating_cycles_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contextual_legends", :force => true do |t|
    t.text     "content"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contextual_legends", ["url", "id"], :name => "contextual_legends_index", :unique => true

  create_table "creeds", :force => true do |t|
    t.string   "description"
    t.integer  "company_id"
    t.integer  "user_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "functions", :force => true do |t|
    t.string   "content"
    t.integer  "area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "key_activities", :force => true do |t|
    t.string   "name"
    t.integer  "operating_cycles_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operating_cycles", :force => true do |t|
    t.string   "name"
    t.text     "reason"
    t.integer  "internal_id"
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "positions", :force => true do |t|
    t.string  "name"
    t.integer "role_equivalence"
  end

  create_table "services", :force => true do |t|
    t.string   "name"
    t.integer  "operating_cycles_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "strategic_line_strategic_objectives", :force => true do |t|
    t.integer "strategic_line_id"
    t.integer "strategic_objective_id"
  end

  create_table "strategic_lines", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "strategic_objectives", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "swots", :force => true do |t|
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", :force => true do |t|
    t.string   "description"
    t.integer  "priority"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "name"
    t.string   "last_name"
    t.integer  "company_id"
    t.integer  "area_id"
    t.integer  "position_id"
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "grade"
    t.string   "officce_phone"
    t.string   "ext_phone"
    t.string   "celular_phone"
    t.string   "home_phone"
    t.string   "fax"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
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

end
