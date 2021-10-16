class CreateTodaymealRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :todaymeal_recipes do |t|

      t.timestamps
    end
  end
end
