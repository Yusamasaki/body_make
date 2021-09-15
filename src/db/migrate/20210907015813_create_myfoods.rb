class CreateMyfoods < ActiveRecord::Migration[5.2]
  def change
    create_table :myfoods do |t|
      t.string :food_name
      t.integer :amount
      t.integer :caloriie
      t.integer :protein
      t.integer :fat
      t.integer :carbo
      t.integer :suger
      t.integer :dietary_fiber
      t.integer :salt
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
