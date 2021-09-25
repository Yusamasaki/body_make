class CreateTraningevents < ActiveRecord::Migration[5.2]
  def change
    create_table :traningevents do |t|
      t.string :bodypart
      t.string :traning_type
      t.string :traning_name
      t.string :sub_bodypart
      
      t.references :user, foreign_key: true
      t.references :traningtype, foreign_key: true

      t.timestamps
    end
  end
end
