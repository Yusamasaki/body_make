class CreateMyfoods < ActiveRecord::Migration[5.2]
  def change
    create_table :myfoods do |t|
      t.string :food_name   
      t.float :calorie, default: 0
      t.float :protein, default: 0
      t.float :fat, default: 0
      t.float :carbo, default: 0
      t.float :sugar, default: 0
      t.float :dietary_fiber, default: 0
      t.float :salt, default: 0
      
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
