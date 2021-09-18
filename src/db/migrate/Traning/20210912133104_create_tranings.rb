class CreateTranings < ActiveRecord::Migration[5.2]
  def change
    create_table :tranings do |t|
      t.date :start_time
      t.string :traning_name
      t.string :sub_bodypart
      t.string :bodypart
      t.integer :traning_weight
      t.integer :traning_reps
      t.string :traning_note

      t.timestamps
    end
  end
end
