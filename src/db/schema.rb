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

ActiveRecord::Schema.define(version: 2021_09_20_140736) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bmrs_on_user_id"
  end

  create_table "bodyparts", force: :cascade do |t|
    t.string "body_part"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bodyweights", force: :cascade do |t|
    t.date "start_time"
    t.float "body_weight"
    t.float "bodyfat_percentage"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bodyweights_on_user_id"
  end

  create_table "exercise_categories", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exercise_contents", force: :cascade do |t|
    t.string "content", default: "", null: false
    t.integer "calorie", default: 0, null: false
    t.bigint "exercise_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_category_id"], name: "index_exercise_contents_on_exercise_category_id"
  end

  create_table "myfoods", force: :cascade do |t|
    t.string "food_name"
    t.float "amount"
    t.float "caloriie"
    t.float "protein"
    t.float "fat"
    t.float "carbo"
    t.float "suger"
    t.float "dietary_fiber"
    t.float "salt"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_myfoods_on_user_id"
  end

  create_table "pfc_ratios", force: :cascade do |t|
    t.float "protein"
    t.float "fat"
    t.float "carbo"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_pfc_ratios_on_user_id"
  end

  create_table "recipefoods", force: :cascade do |t|
    t.string "food_name"
    t.float "amount"
    t.float "calorie"
    t.float "protein"
    t.float "fat"
    t.float "carbo"
    t.float "suger"
    t.float "dietary_fiber"
    t.float "salt"
    t.bigint "user_id"
    t.bigint "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_recipefoods_on_recipe_id"
    t.index ["user_id"], name: "index_recipefoods_on_user_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "recipe_name"
    t.float "calorie"
    t.float "protein"
    t.float "fat"
    t.float "carbo"
    t.float "suger"
    t.float "dietary_fiber"
    t.float "salt"
    t.string "note"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "sns_credentials", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sns_credentials_on_user_id"
  end

  create_table "targetweights", force: :cascade do |t|
    t.integer "now_body_weight"
    t.integer "goal_body_weight"
    t.integer "now_bodyfat_percentage"
    t.integer "goal_bodyfat_percentage"
    t.datetime "beginning_date", default: "2021-09-20 14:10:33"
    t.datetime "target_date", default: "2021-09-21 14:10:33"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_targetweights_on_user_id"
  end

  create_table "timezones", force: :cascade do |t|
    t.string "time_zone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "today_exercises", force: :cascade do |t|
    t.date "start_time", default: "2021-09-20", null: false
    t.datetime "exercise_time", default: "2021-09-19 15:00:00", null: false
    t.string "note"
    t.bigint "exercise_category_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_category_id"], name: "index_today_exercises_on_exercise_category_id"
    t.index ["user_id"], name: "index_today_exercises_on_user_id"
  end

  create_table "todaymeals", force: :cascade do |t|
    t.datetime "start_time"
    t.string "food_name"
    t.float "calorie"
    t.float "protein"
    t.float "fat"
    t.float "carbo"
    t.float "suger"
    t.float "dietary_fiber"
    t.float "salt"
    t.string "note"
    t.bigint "user_id"
    t.bigint "timezone_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["timezone_id"], name: "index_todaymeals_on_timezone_id"
    t.index ["user_id"], name: "index_todaymeals_on_user_id"
  end

  create_table "traning_bodyparts", force: :cascade do |t|
    t.string "sub_body_part"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "traningevents", force: :cascade do |t|
    t.string "bodypart"
    t.string "traning_type"
    t.string "traning_name"
    t.string "sub_bodypart"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tranings", force: :cascade do |t|
    t.date "start_time"
    t.string "traning_name"
    t.string "sub_bodypart"
    t.string "bodypart"
    t.float "traning_weight"
    t.float "traning_reps"
    t.string "traning_note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "traningtypes", force: :cascade do |t|
    t.string "traning_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bmrs", "users"
  add_foreign_key "bodyweights", "users"
  add_foreign_key "exercise_contents", "exercise_categories"
  add_foreign_key "myfoods", "users"
  add_foreign_key "pfc_ratios", "users"
  add_foreign_key "recipefoods", "users"
  add_foreign_key "recipes", "users"
  add_foreign_key "sns_credentials", "users"
  add_foreign_key "targetweights", "users"
  add_foreign_key "today_exercises", "exercise_categories"
  add_foreign_key "today_exercises", "users"
  add_foreign_key "todaymeals", "users"
end
