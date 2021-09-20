class CreatePfcRatios < ActiveRecord::Migration[5.2]
  def change
    create_table :pfc_ratios do |t|
      t.float :protein
      t.float :fat
      t.float :carbo

      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
