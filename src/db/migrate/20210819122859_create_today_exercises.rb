class CreateTodayExercises < ActiveRecord::Migration[5.2]
  def change
    create_table :today_exercises do |t|
      t.date :start_time, null: false, default: Date.current
      t.datetime :exercise_time, null: false, default: Time.current.change(hour: 0, min: 0, sec: 0)
      t.integer :calorie, null: false, default: 0
      t.string :note
      t.references :exercise_category, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
