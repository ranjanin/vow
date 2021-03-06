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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151202112816) do

  create_table "addresses", force: true do |t|
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "address_line_3"
    t.string   "city"
    t.string   "country"
    t.integer  "authuser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
  end

  create_table "admins", force: true do |t|
    t.integer  "authuser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authusers", force: true do |t|
    t.string   "email",                  default: "",          null: false
    t.string   "encrypted_password",     default: ""
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,           null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "permalink"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.boolean  "approved",               default: false
    t.string   "current_role"
    t.date     "date_of_birth"
    t.string   "image"
    t.string   "role"
    t.string   "invoice_format",         default: "automatic"
    t.string   "invoice_string"
    t.boolean  "invited_user_status"
  end

  add_index "authusers", ["approved"], name: "index_authusers_on_approved"
  add_index "authusers", ["email"], name: "index_authusers_on_email", unique: true
  add_index "authusers", ["invitation_token"], name: "index_authusers_on_invitation_token", unique: true
  add_index "authusers", ["invitations_count"], name: "index_authusers_on_invitations_count"
  add_index "authusers", ["invited_by_id"], name: "index_authusers_on_invited_by_id"
  add_index "authusers", ["reset_password_token"], name: "index_authusers_on_reset_password_token", unique: true

  create_table "bankdetails", force: true do |t|
    t.integer  "authuser_id"
    t.string   "bank_account_number"
    t.string   "ifsc_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bill_other_charges", force: true do |t|
    t.integer  "bill_id"
    t.integer  "other_charges_information_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "other_charges_amount"
  end

  create_table "bill_taxes", force: true do |t|
    t.integer  "line_item_id"
    t.integer  "tax_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bill_id"
    t.string   "tax_name"
    t.float    "tax_rate"
    t.string   "tax_type"
    t.float    "tax_amount"
    t.string   "tax_type_of_tax"
  end

  create_table "bills", force: true do |t|
    t.string   "invoice_number"
    t.datetime "bill_date"
    t.integer  "customer_id"
    t.integer  "authuser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "other_information"
    t.float    "total_bill_price"
    t.float    "grand_total"
    t.float    "other_charges"
    t.string   "esugam"
    t.integer  "client_id"
    t.string   "transporter_name"
    t.string   "vechicle_number"
    t.string   "gc_lr_number"
    t.datetime "lr_date"
    t.string   "error_message"
    t.string   "pdf_format"
    t.integer  "primary_user_id"
    t.string   "record_number"
    t.string   "invoice_format"
    t.string   "updated_info"
    t.float    "discount"
    t.string   "tax_type"
  end

  create_table "clients", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "authuser_id"
    t.string   "remarks"
    t.string   "company"
    t.boolean  "user_role"
    t.string   "role_user"
    t.integer  "created_by"
    t.string   "referred_by"
    t.integer  "referral_id"
  end

  create_table "customers", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "tin_number"
    t.string   "phone_number"
    t.string   "address"
    t.string   "city"
    t.integer  "authuser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
    t.string   "state"
    t.string   "pin_code"
    t.integer  "primary_user_id"
    t.string   "company_name"
  end

  create_table "dashboards", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enquiry_forms", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.string   "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoice_number_records", force: true do |t|
    t.string   "number"
    t.integer  "bill_id"
    t.integer  "authuser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoice_records", force: true do |t|
    t.string   "number"
    t.integer  "bill_id"
    t.integer  "authuser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_items", force: true do |t|
    t.integer  "product_id"
    t.integer  "bill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "quantity"
    t.float    "unit_price"
    t.float    "total_price"
    t.float    "total_item_price"
    t.float    "tax_rate"
    t.integer  "tax_id"
    t.string   "tax_type"
    t.text     "item_description"
  end

  create_table "main_categories", force: true do |t|
    t.string   "commodity_name"
    t.string   "commodity_code"
    t.string   "sub_commodity_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  add_index "main_categories", ["permalink"], name: "index_main_categories_on_permalink", unique: true

  create_table "main_roles", force: true do |t|
    t.string   "role_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", force: true do |t|
    t.integer  "authuser_id"
    t.string   "phone_number"
    t.datetime "membership_start_date"
    t.datetime "membership_end_date"
    t.integer  "membership_duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "other_charges_informations", force: true do |t|
    t.string   "other_charges"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "authuser_id"
    t.integer  "bill_id"
  end

  create_table "permissions", force: true do |t|
    t.integer  "authuser_id"
    t.integer  "main_role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "default",      default: false
  end

  create_table "products", force: true do |t|
    t.string   "product_name"
    t.string   "units"
    t.integer  "usercategory_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "authuser_id"
    t.string   "permalink"
    t.integer  "primary_user_id"
  end

  create_table "referral_types", force: true do |t|
    t.string   "referral_type"
    t.string   "pricing"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "referrals", force: true do |t|
    t.string   "name"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "state"
    t.string   "country"
    t.string   "mobile_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.integer  "referral_type_id"
  end

  create_table "taxes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "authuser_id"
    t.string   "tax_name"
    t.string   "tax_type"
    t.string   "tax_on_tax"
    t.string   "tax_type_of_tax"
  end

  create_table "tin_numbers", force: true do |t|
    t.string   "state"
    t.string   "tin_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unregistered_customers", force: true do |t|
    t.string   "customer_name"
    t.string   "phone_number"
    t.string   "address"
    t.string   "city"
    t.integer  "authuser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.integer  "bill_id"
    t.string   "email"
  end

  create_table "usercategories", force: true do |t|
    t.integer "authuser_id"
    t.integer "main_category_id"
    t.integer "auth_user_category_id"
    t.string  "commodity_name"
    t.integer "primary_user_id"
  end

  create_table "users", force: true do |t|
    t.string   "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "authuser_id"
    t.integer  "client_id"
    t.string   "esugam_username"
    t.string   "esugam_password"
    t.string   "tin_number"
    t.string   "company"
  end

end
