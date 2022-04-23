class CreateTodaymealRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :todaymeal_recipes do |t|
      
      t.date :start_time
      t.float :amount, default: 1
      t.string :note
      
      t.references :user, foreign_key: true
      t.references :timezone, foreign_key: true
      t.references :recipe, foreign_key: true

      t.timestamps
    end
  end
end
