class CreateExerciseContents < ActiveRecord::Migration[5.2]
  def change
    create_table :exercise_contents do |t|
      t.string :content, default: "", null: false
      t.integer :calorie, null: false, default: 0
      t.references :exercise_category, foreign_key: true

      t.timestamps
    end
  end
end
