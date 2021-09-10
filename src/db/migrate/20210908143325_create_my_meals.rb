class CreateMyMeals < ActiveRecord::Migration[5.2]
  def change
    create_table :my_meals do |t|
      t.datetime :start_time
      t.string :food_name
      t.integer :calorie
      t.string :protein
      t.string :fat
      t.string :carbo
      t.integer :suger
      t.integer :dietary_fiber
      t.integer :salt
      t.string :note
      t.references :timezone
      t.references :user, foreign_key: true
      

      t.timestamps
    end
  end
end
