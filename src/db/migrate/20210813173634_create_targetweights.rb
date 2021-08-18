class CreateTargetweights < ActiveRecord::Migration[5.2]
  def change
    create_table :targetweights do |t|
      t.integer :body_weight
      t.integer :bodyfat_parcentag

      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
