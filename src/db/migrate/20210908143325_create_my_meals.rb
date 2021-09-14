class CreateMyMeals < ActiveRecord::Migration[5.2]
  def change
    create_table :my_meals do |t|
      t.datetime :start_time
      t.string :food_name
      t.float :calorie
      t.string :protein
      t.string :fat
      t.string :carbo
      t.float :suger
      t.float :dietary_fiber
      t.float :salt
      t.string :note
      t.references :timezone
      t.references :user, foreign_key: true
      

      t.timestamps
    end
  end
end
