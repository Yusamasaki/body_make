class CreateMealsAnalyses < ActiveRecord::Migration[5.2]
  def change
    create_table :meals_analyses do |t|
      
      t.date :start_time
      t.float :calorie
      
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
