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

ActiveRecord::Schema.define(:version => 20120603181111) do

  create_table "additional_images", :force => true do |t|
    t.integer  "product_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.string   "image_file_size"
    t.string   "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "additional_images", ["id"], :name => "index_additional_images_on_id"
  add_index "additional_images", ["product_id"], :name => "index_additional_images_on_product_id"

  create_table "baskets", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "purchased_at"
  end

  add_index "baskets", ["id"], :name => "index_baskets_on_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "dasherized_name"
    t.string   "google_category"
  end

  add_index "categories", ["dasherized_name"], :name => "index_categories_on_dasherized_name"
  add_index "categories", ["id"], :name => "index_categories_on_id"
  add_index "categories", ["lft"], :name => "index_categories_on_lft"

  create_table "line_items", :force => true do |t|
    t.integer  "product_id"
    t.integer  "basket_id"
    t.integer  "quantity",   :default => 1
    t.decimal  "unit_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "line_items", ["basket_id"], :name => "index_line_items_on_basket_id"
  add_index "line_items", ["id"], :name => "index_line_items_on_id"
  add_index "line_items", ["product_id"], :name => "index_line_items_on_product_id"

  create_table "payment_notifications", :force => true do |t|
    t.text     "params"
    t.integer  "basket_id"
    t.string   "status"
    t.string   "transaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payment_notifications", ["basket_id"], :name => "index_payment_notifications_on_basket_id"
  add_index "payment_notifications", ["id"], :name => "index_payment_notifications_on_id"

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price",              :precision => 8, :scale => 2
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "category_id"
    t.boolean  "featured"
    t.decimal  "postage_cost",       :precision => 8, :scale => 2
    t.string   "brand"
    t.string   "mpn"
    t.string   "condition"
    t.string   "barcode"
  end

  add_index "products", ["category_id"], :name => "index_products_on_category_id"
  add_index "products", ["featured"], :name => "index_products_on_featured"
  add_index "products", ["id"], :name => "index_products_on_id"
  add_index "products", ["name"], :name => "index_products_on_name"
  add_index "products", ["quantity", "category_id", "name"], :name => "index_products_on_quantity_and_category_id_and_name"
  add_index "products", ["quantity", "name"], :name => "index_products_on_quantity_and_name"
  add_index "products", ["quantity"], :name => "index_products_on_quantity"

  create_table "users", :force => true do |t|
    t.string   "email",                              :default => "", :null => false
    t.string   "encrypted_password",  :limit => 128, :default => "", :null => false
    t.datetime "remember_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["id"], :name => "index_users_on_id"

end
