class CreateTraningAnalyses < ActiveRecord::Migration[5.2]
  def change
    create_table :traning_analyses do |t|
      
      t.date :start_time
      t.string :total_load
      t.float :max_load
      
      t.references :user, foreign_key: true
      t.references :traningevent, foreign_key: true

      t.timestamps
    end
  end
end
