class CreateBodyweights < ActiveRecord::Migration[5.2]
  def change
    create_table :bodyweights do |t|
      t.datetime :start_time
      t.integer :body_weight
      t.integer :bodyfat_percentage
      
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
