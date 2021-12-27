class CreateTargetweights < ActiveRecord::Migration[5.2]
  def change
    create_table :targetweights do |t|
      t.float :now_body_weight
      t.float :goal_body_weight
      t.float :now_bodyfat_percentage
      t.float :goal_bodyfat_percentage
      
      t.datetime :beginning_date, default: Time.current
      t.datetime :target_date, default: Time.current.tomorrow
      
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
