class CreateTranings < ActiveRecord::Migration[5.2]
  def change
    create_table :tranings do |t|
      t.date :start_time
      t.string :traning_name
      t.string :sub_bodypart
      t.string :bodypart
      t.float :traning_weight
      t.float :traning_reps
      t.string :traning_note

      t.timestamps
    end
  end
end
