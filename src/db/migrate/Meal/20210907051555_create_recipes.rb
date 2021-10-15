class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :recipe_name
      t.float :amount
      
      t.string :note
      
      t.references :user, foreign_key: true
      t.references :timezone, foreign_key: true

      t.timestamps
    end
  end
end
