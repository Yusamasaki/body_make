class CreateRecipefoods < ActiveRecord::Migration[5.2]
  def change
    create_table :recipefoods do |t|
      t.float :amount, default: 1
      
      t.references :user, foreign_key: true
      t.references :recipe, foreign_key: true
      t.references :myfood, foreign_key: true

      t.timestamps
    end
  end
end
