class CreateBodyweights < ActiveRecord::Migration[5.2]
  def change
    create_table :bodyweights do |t|
      t.date :start_time
      t.float :body_weight
      t.float :bodyfat_percentage
      
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
