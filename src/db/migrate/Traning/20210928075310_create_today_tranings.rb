class CreateTodayTranings < ActiveRecord::Migration[5.2]
  def change
    create_table :today_tranings do |t|
      
      t.date :start_time
      
      t.float :traning_weight
      t.float :traning_reps
      t.string :traning_note
      
      t.float :total_load
      
      t.references :user, foreign_key: true
      t.references :traningevent, foreign_key: true
      t.references :bodypart, foreign_key: true

      t.timestamps
    end
  end
end
