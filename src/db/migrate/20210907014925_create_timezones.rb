class CreateTimezones < ActiveRecord::Migration[5.2]
  def change
    create_table :timezones do |t|
      t.string :time_zone

      t.timestamps
    end
  end
end
