class CreateRecipefoods < ActiveRecord::Migration[5.2]
  def change
    create_table :recipefoods do |t|
      t.string :food_name
      t.float :amount
      t.float :calorie
      t.float :protein
      t.float :fat
      t.float :carbo
      t.float :suger
      t.float :dietary_fiber
      t.float :salt
      t.references :user, foreign_key: true
      t.references :recipe


      t.timestamps
    end
  end
end
