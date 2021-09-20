class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :recipe_name
      t.integer :calorie
      t.integer :protein
      t.integer :fat
      t.integer :carbo
      t.integer :suger
      t.integer :dietary_fiber
      t.integer :salt
      t.string :note
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
