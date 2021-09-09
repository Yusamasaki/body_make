class CreateTargetweights < ActiveRecord::Migration[5.2]
  def change
    create_table :targetweights do |t|
      t.integer :now_body_weight
      t.integer :goal_body_weight
      t.integer :now_bodyfat_percentage
      t.integer :goal_bodyfat_percentage
      
      t.datetime :Beginning_date, default: Time.current
      t.datetime :target_date, default: Time.current
      
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
