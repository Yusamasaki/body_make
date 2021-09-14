class CreateFoodMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :food_menus do |t|
      t.string :food_name
      t.float :amount
      t.float :calorie
      t.float :protein
      t.float :fat
      t.float :carbo
      t.float :suger
      t.float :salt

      t.timestamps
    end
  end
end
