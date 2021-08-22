class CreateTargetweights < ActiveRecord::Migration[5.2]
  def change
    create_table :targetweights do |t|
      t.integer :body_weight
      t.integer :bodyfat_parcentage
      t.integer :target_days
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
