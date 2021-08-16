class CreateBmrs < ActiveRecord::Migration[5.2]
  def change
    create_table :bmrs do |t|
      t.string :gender
      t.integer :age
      t.integer :height

      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
