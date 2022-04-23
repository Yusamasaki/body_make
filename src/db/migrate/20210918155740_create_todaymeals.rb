class CreateTodaymeals < ActiveRecord::Migration[5.2]
  def change
    create_table :todaymeals do |t|
      t.date :start_time
      t.float :amount, default: 1
      t.string :note
      
      t.references :user, foreign_key: true
      t.references :timezone, foreign_key: true
      t.references :myfood, foreign_key: true

      t.timestamps
    end
  end
end
