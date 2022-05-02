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

ActiveRecord::Schema[7.0].define(version: 2022_05_01_173253) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "provider"
    t.string "uid"
    t.string "username"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "bmrs", force: :cascade do |t|
    t.string "gender"
    t.integer "age"
    t.float "height"
    t.string "activity"
    t.bigint "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["user_id"], name: "index_bmrs_on_user_id"
  end

  create_table "bodyweights", force: :cascade do |t|
    t.date "start_time"
    t.float "body_weight"
    t.float "bodyfat_percentage"
    t.bigint "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["user_id"], name: "index_bodyweights_on_user_id"
  end

  create_table "meals_analyses", force: :cascade do |t|
    t.date "start_time"
    t.float "calorie"
    t.bigint "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["user_id"], name: "index_meals_analyses_on_user_id"
  end

  create_table "myfoods", force: :cascade do |t|
    t.string "food_name"
    t.float "calorie", default: 0.0
    t.float "protein", default: 0.0
    t.float "fat", default: 0.0
    t.float "carbo", default: 0.0
    t.float "sugar", default: 0.0
    t.float "dietary_fiber", default: 0.0
    t.float "salt", default: 0.0
    t.bigint "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["user_id"], name: "index_myfoods_on_user_id"
  end

  create_table "pfc_ratios", force: :cascade do |t|
    t.float "protein", default: 20.0
    t.float "fat", default: 20.0
    t.float "carbo", default: 60.0
    t.bigint "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["user_id"], name: "index_pfc_ratios_on_user_id"
  end

  create_table "recipefoods", force: :cascade do |t|
    t.float "amount", default: 1.0
    t.bigint "user_id"
    t.bigint "recipe_id"
    t.bigint "myfood_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["myfood_id"], name: "index_recipefoods_on_myfood_id"
    t.index ["recipe_id"], name: "index_recipefoods_on_recipe_id"
    t.index ["user_id"], name: "index_recipefoods_on_user_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "recipe_name"
    t.float "calorie"
    t.float "protein"
    t.float "fat"
    t.float "carbo"
    t.float "sugar"
    t.float "dietary_fiber"
    t.float "salt"
    t.string "note"
    t.bigint "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "id_digest"
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "targetweights", force: :cascade do |t|
    t.float "now_body_weight"
    t.float "goal_body_weight"
    t.float "now_bodyfat_percentage"
    t.float "goal_bodyfat_percentage"
    t.datetime "beginning_date", precision: nil, default: "2022-05-01 17:33:48"
    t.datetime "target_date", precision: nil, default: "2022-05-02 17:33:48"
    t.bigint "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["user_id"], name: "index_targetweights_on_user_id"
  end

  create_table "timezones", force: :cascade do |t|
    t.string "time_zone"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "todaymeal_recipes", force: :cascade do |t|
    t.date "start_time"
    t.float "amount", default: 1.0
    t.string "note"
    t.bigint "user_id"
    t.bigint "timezone_id"
    t.bigint "recipe_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["recipe_id"], name: "index_todaymeal_recipes_on_recipe_id"
    t.index ["timezone_id"], name: "index_todaymeal_recipes_on_timezone_id"
    t.index ["user_id"], name: "index_todaymeal_recipes_on_user_id"
  end

  create_table "todaymeals", force: :cascade do |t|
    t.date "start_time"
    t.float "amount", default: 1.0
    t.string "note"
    t.bigint "user_id"
    t.bigint "timezone_id"
    t.bigint "myfood_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["myfood_id"], name: "index_todaymeals_on_myfood_id"
    t.index ["timezone_id"], name: "index_todaymeals_on_timezone_id"
    t.index ["user_id"], name: "index_todaymeals_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "nickname", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "provider"
    t.string "uid"
    t.string "username"
    t.string "id_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bmrs", "users"
  add_foreign_key "bodyweights", "users"
  add_foreign_key "meals_analyses", "users"
  add_foreign_key "myfoods", "users"
  add_foreign_key "pfc_ratios", "users"
  add_foreign_key "recipefoods", "myfoods"
  add_foreign_key "recipefoods", "recipes"
  add_foreign_key "recipefoods", "users"
  add_foreign_key "recipes", "users"
  add_foreign_key "targetweights", "users"
  add_foreign_key "todaymeal_recipes", "recipes"
  add_foreign_key "todaymeal_recipes", "timezones"
  add_foreign_key "todaymeal_recipes", "users"
  add_foreign_key "todaymeals", "myfoods"
  add_foreign_key "todaymeals", "timezones"
  add_foreign_key "todaymeals", "users"
end
