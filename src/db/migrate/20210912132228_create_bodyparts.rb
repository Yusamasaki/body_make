class CreateBodyparts < ActiveRecord::Migration[5.2]
  def change
    create_table :bodyparts do |t|
      
      t.string :body_part
      t.integer :recovery_day

      t.timestamps
    end
  end
end
