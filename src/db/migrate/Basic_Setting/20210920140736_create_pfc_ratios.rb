class CreatePfcRatios < ActiveRecord::Migration[5.2]
  def change
    create_table :pfc_ratios do |t|
      t.float :protein, default: 20
      t.float :fat, default: 20
      t.float :carbo, default: 60

      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
