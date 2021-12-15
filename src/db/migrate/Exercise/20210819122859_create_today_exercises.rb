class CreateTodayExercises < ActiveRecord::Migration[5.2]
  def change
    create_table :today_exercises do |t|
      t.date :start_time, null: false, default: Date.current
      t.integer :exercise_time_hour, null: false, default: 0
      t.integer :exercise_time_min, null: false, default: 0
      t.float :body_weight, null: false, default: 0
      t.string :note
      t.references :exercise_category, foreign_key: true
      t.references :exercise_content, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
