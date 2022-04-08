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

ActiveRecord::Schema.define(version: 2022_04_08_122348) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
  end

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "recipe_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipe_id"], name: "index_bookmarks_on_recipe_id"
    t.index ["user_id", "recipe_id"], name: "index_bookmarks_on_user_id_and_recipe_id", unique: true
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "rakuten_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "child_categories", force: :cascade do |t|
    t.bigint "category_id"
    t.string "name"
    t.integer "rakuten_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_child_categories_on_category_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.text "message", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "food_costs", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "price_id", null: false
    t.string "quantity_unit"
    t.float "cost"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "note"
    t.index ["price_id"], name: "index_food_costs_on_price_id"
    t.index ["recipe_id"], name: "index_food_costs_on_recipe_id"
  end

  create_table "ingredient_units", force: :cascade do |t|
    t.bigint "ingredient_id", null: false
    t.bigint "unit_id", null: false
    t.float "ratio", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ingredient_id", "unit_id"], name: "index_ingredient_units_on_ingredient_id_and_unit_id", unique: true
    t.index ["ingredient_id"], name: "index_ingredient_units_on_ingredient_id"
    t.index ["unit_id"], name: "index_ingredient_units_on_unit_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.string "base_unit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "prices", force: :cascade do |t|
    t.bigint "ingredient_id", null: false
    t.integer "purchase_price", null: false
    t.float "quantity", null: false
    t.bigint "unit_id", null: false
    t.float "one_base_unit_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ingredient_id", "unit_id"], name: "index_prices_on_ingredient_id_and_unit_id", unique: true
    t.index ["ingredient_id"], name: "index_prices_on_ingredient_id"
    t.index ["unit_id"], name: "index_prices_on_unit_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "recipe_url", null: false
    t.string "cuisine_name", null: false
    t.string "originator", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "how_many"
    t.integer "cook_cost"
    t.integer "one_meal_cost"
  end

  create_table "synonyms", force: :cascade do |t|
    t.bigint "ingredient_id", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ingredient_id"], name: "index_synonyms_on_ingredient_id"
  end

  create_table "units", force: :cascade do |t|
    t.string "unit", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "bookmarks", "recipes"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "food_costs", "prices"
  add_foreign_key "food_costs", "recipes"
  add_foreign_key "ingredient_units", "ingredients"
  add_foreign_key "ingredient_units", "units"
  add_foreign_key "prices", "ingredients"
  add_foreign_key "prices", "units"
  add_foreign_key "synonyms", "ingredients"
end
