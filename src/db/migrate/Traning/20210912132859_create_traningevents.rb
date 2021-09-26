class CreateTraningevents < ActiveRecord::Migration[5.2]
  def change
    create_table :traningevents do |t|
      t.string :body_part
      t.string :traning_type
      t.string :traning_name
      t.string :sub_body_part
      
      t.references :user, foreign_key: true
      t.references :traningtype, foreign_key: true
      t.references :bodypart, foreign_key: true

      t.timestamps
    end
  end
end
