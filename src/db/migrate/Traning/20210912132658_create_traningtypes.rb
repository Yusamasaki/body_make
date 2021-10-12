class CreateTraningtypes < ActiveRecord::Migration[5.2]
  def change
    create_table :traningtypes do |t|
      
      t.string :traning_type

      t.timestamps
    end
  end
end
