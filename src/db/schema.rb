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

ActiveRecord::Schema.define(version: 2021_12_23_014245) do

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
    t.integer "recovery_day"
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
    t.string "content"
    t.float "mets"
    t.bigint "exercise_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_category_id"], name: "index_exercise_contents_on_exercise_category_id"
  end

  create_table "meals_analyses", force: :cascade do |t|
    t.date "start_time"
    t.float "calorie"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_myfoods_on_user_id"
  end

  create_table "pfc_ratios", force: :cascade do |t|
    t.float "protein", default: 20.0
    t.float "fat", default: 20.0
    t.float "carbo", default: 60.0
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_pfc_ratios_on_user_id"
  end

  create_table "recipefoods", force: :cascade do |t|
    t.float "amount", default: 1.0
    t.bigint "user_id"
    t.bigint "recipe_id"
    t.bigint "myfood_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "id_digest"
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "sub_bodyparts", force: :cascade do |t|
    t.string "sub_body_part"
    t.integer "recovery_day"
    t.bigint "bodypart_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bodypart_id"], name: "index_sub_bodyparts_on_bodypart_id"
  end

  create_table "targetweights", force: :cascade do |t|
    t.float "now_body_weight"
    t.float "goal_body_weight"
    t.float "now_bodyfat_percentage"
    t.float "goal_bodyfat_percentage"
    t.datetime "beginning_date", default: "2021-12-23 05:20:46"
    t.datetime "target_date", default: "2021-12-24 05:20:46"
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
    t.date "start_time", default: "2021-12-23", null: false
    t.integer "exercise_time_hour", default: 0, null: false
    t.integer "exercise_time_min", default: 0, null: false
    t.float "body_weight", default: 0.0, null: false
    t.string "note"
    t.bigint "exercise_category_id"
    t.bigint "exercise_content_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_category_id"], name: "index_today_exercises_on_exercise_category_id"
    t.index ["exercise_content_id"], name: "index_today_exercises_on_exercise_content_id"
    t.index ["user_id"], name: "index_today_exercises_on_user_id"
  end

  create_table "today_tranings", force: :cascade do |t|
    t.date "start_time"
    t.float "traning_weight"
    t.float "traning_reps"
    t.string "traning_note"
    t.float "total_load"
    t.bigint "bodypart_id"
    t.bigint "user_id"
    t.bigint "traningevent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["traningevent_id"], name: "index_today_tranings_on_traningevent_id"
    t.index ["user_id"], name: "index_today_tranings_on_user_id"
  end

  create_table "todaymeal_recipes", force: :cascade do |t|
    t.date "start_time"
    t.float "amount", default: 1.0
    t.string "note"
    t.bigint "user_id"
    t.bigint "timezone_id"
    t.bigint "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["myfood_id"], name: "index_todaymeals_on_myfood_id"
    t.index ["timezone_id"], name: "index_todaymeals_on_timezone_id"
    t.index ["user_id"], name: "index_todaymeals_on_user_id"
  end

  create_table "traning_analyses", force: :cascade do |t|
    t.date "start_time"
    t.string "total_load"
    t.float "max_load"
    t.bigint "user_id"
    t.bigint "traningevent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["traningevent_id"], name: "index_traning_analyses_on_traningevent_id"
    t.index ["user_id"], name: "index_traning_analyses_on_user_id"
  end

  create_table "traningevents", force: :cascade do |t|
    t.string "traning_name"
    t.bigint "subbodypart_id"
    t.bigint "traningtype_id"
    t.bigint "bodypart_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_traningevents_on_user_id"
  end

  create_table "traningtypes", force: :cascade do |t|
    t.string "traning_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "nickname", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "username"
    t.string "id_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bmrs", "users"
  add_foreign_key "bodyweights", "users"
  add_foreign_key "exercise_contents", "exercise_categories"
  add_foreign_key "meals_analyses", "users"
  add_foreign_key "myfoods", "users"
  add_foreign_key "pfc_ratios", "users"
  add_foreign_key "recipefoods", "myfoods"
  add_foreign_key "recipefoods", "recipes"
  add_foreign_key "recipefoods", "users"
  add_foreign_key "recipes", "users"
  add_foreign_key "sub_bodyparts", "bodyparts"
  add_foreign_key "targetweights", "users"
  add_foreign_key "today_exercises", "exercise_categories"
  add_foreign_key "today_exercises", "exercise_contents"
  add_foreign_key "today_exercises", "users"
  add_foreign_key "today_tranings", "traningevents"
  add_foreign_key "today_tranings", "users"
  add_foreign_key "todaymeal_recipes", "recipes"
  add_foreign_key "todaymeal_recipes", "timezones"
  add_foreign_key "todaymeal_recipes", "users"
  add_foreign_key "todaymeals", "myfoods"
  add_foreign_key "todaymeals", "timezones"
  add_foreign_key "todaymeals", "users"
  add_foreign_key "traning_analyses", "traningevents"
  add_foreign_key "traning_analyses", "users"
  add_foreign_key "traningevents", "users"
end
