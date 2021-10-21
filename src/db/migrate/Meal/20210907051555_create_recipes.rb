class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :recipe_name
      t.float :calorie, default: 0
      t.float :protein, default: 0
      t.float :fat, default: 0
      t.float :carbo, default: 0
      t.float :sugar, default: 0
      t.float :dietary_fiber, default: 0
      t.float :salt, default: 0
      t.string :note
      
      t.references :user, foreign_key: true
      t.references :timezone, foreign_key: true

      t.timestamps
    end
  end
end
