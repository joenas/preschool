class CreateHour < ActiveRecord::Migration[5.0]
  def change
    create_table :hours do |t|
      t.integer :preschool_id
      t.integer :day_of_week
      t.time :opens
      t.time :closes
      t.string :note
    end
  end
end
