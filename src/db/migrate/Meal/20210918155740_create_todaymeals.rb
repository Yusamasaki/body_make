class CreateTodaymeals < ActiveRecord::Migration[5.2]
  def change
    create_table :todaymeals do |t|
      t.datetime :start_time
      t.string :food_name
      t.float :calorie
      t.float :protein
      t.float :fat
      t.float :carbo
      t.float :suger
      t.float :dietary_fiber
      t.float :salt
      t.string :note
      t.references :user, foreign_key: true
      t.references :timezone

      t.timestamps
    end
  end
end
