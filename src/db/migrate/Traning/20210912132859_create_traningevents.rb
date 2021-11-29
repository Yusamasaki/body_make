class CreateTraningevents < ActiveRecord::Migration[5.2]
  def change
    create_table :traningevents do |t|
      
      t.string :traning_name
      t.string :sub_body_part
      
      t.bigint :subbodypart_id
      t.bigint :traningtype_id
      t.bigint :bodypart_id
      
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end
