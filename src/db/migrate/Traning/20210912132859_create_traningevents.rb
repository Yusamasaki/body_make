class CreateTraningevents < ActiveRecord::Migration[5.2]
  def change
    create_table :traningevents do |t|
      t.string :bodypart
      t.string :traning_type
      t.string :traning_name
      t.string :sub_bodypart

      t.timestamps
    end
  end
end
