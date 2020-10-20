# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_20_195213) do

  create_table "delivery_people", force: :cascade do |t|
    t.string "name"
  end

  create_table "ice_creams", force: :cascade do |t|
    t.string "name"
    t.string "flavor"
    t.integer "calories"
    t.float "price"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id"
    t.integer "delivery_person_id"
    t.integer "num_of_cones"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "address"
    t.string "payment_method"
  end

end
