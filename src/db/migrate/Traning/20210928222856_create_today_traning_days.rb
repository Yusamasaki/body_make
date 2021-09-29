class CreateTodayTraningDays < ActiveRecord::Migration[5.2]
  def change
    create_table :today_traning_days do |t|
      
      t.date :start_time
      
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
