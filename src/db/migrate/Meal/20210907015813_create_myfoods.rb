class CreateMyfoods < ActiveRecord::Migration[5.2]
  def change
    create_table :myfoods do |t|
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

      t.timestamps
    end
  end
end
