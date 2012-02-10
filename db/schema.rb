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

ActiveRecord::Schema.define(:version => 20120208183629) do

  create_table "areas", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "village_id"
  end

  add_index "areas", ["village_id"], :name => "index_areas_on_village_id"

  create_table "calendar_events", :force => true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.boolean  "all_day",    :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "calender_events", :force => true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events_volunteers", :id => false, :force => true do |t|
    t.integer "event_id"
    t.integer "volunteer_id"
  end

  create_table "shifts", :force => true do |t|
    t.string   "title"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "volunteer_id"
    t.integer  "slot_id"
  end

  add_index "shifts", ["slot_id"], :name => "index_shifts_on_slot_id"
  add_index "shifts", ["volunteer_id"], :name => "index_shifts_on_volunteer_id"

  create_table "slots", :force => true do |t|
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "village_id"
    t.integer  "area_id"
    t.date     "start_date"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "required_shifts"
  end

  add_index "slots", ["area_id"], :name => "index_slots_on_area_id"
  add_index "slots", ["village_id"], :name => "index_slots_on_village_id"

  create_table "villages", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "event_id"
  end

  add_index "villages", ["event_id"], :name => "index_villages_on_event_id"

  create_table "volunteers", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "nick_name"
    t.string   "email"
    t.string   "phone"
    t.string   "shirt_size"
    t.string   "city"
    t.string   "state"
    t.string   "organization"
    t.string   "level"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
