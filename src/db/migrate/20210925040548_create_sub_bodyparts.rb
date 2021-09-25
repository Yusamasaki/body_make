class CreateSubBodyparts < ActiveRecord::Migration[5.2]
  def change
    create_table :sub_bodyparts do |t|

      t.timestamps
    end
  end
end
