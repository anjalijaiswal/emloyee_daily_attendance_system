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

ActiveRecord::Schema.define(:version => 20140901080044) do

  create_table "emp_daily_attendences", :force => true do |t|
    t.string   "employee_code"
    t.date     "date_time"
    t.integer  "actual_working_hrs"
    t.integer  "actual_workingMin"
    t.decimal  "actual_ondesk_time", :precision => 10, :scale => 0
    t.decimal  "office_time",        :precision => 10, :scale => 0
    t.text     "comments"
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  create_table "emp_data", :primary_key => "e_code", :force => true do |t|
    t.string   "e_name"
    t.string   "e_mail"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "emp_records", :primary_key => "e_code", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "temp_data", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
