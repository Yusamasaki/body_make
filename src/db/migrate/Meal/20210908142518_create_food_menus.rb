class CreateFoodMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :food_menus do |t|
      t.string :food_name
      t.integer :amount
      t.integer :calorie
      t.integer :protein
      t.integer :fat
      t.integer :carbo
      t.integer :suger
      t.integer :salt

      t.timestamps
    end
  end
end
