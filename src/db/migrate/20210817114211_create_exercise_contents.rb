class CreateExerciseContents < ActiveRecord::Migration[5.2]
  def change
    create_table :exercise_contents do |t|
      t.string :content
      t.float :mets
      t.references :exercise_category, foreign_key: true

      t.timestamps
    end
  end
end
