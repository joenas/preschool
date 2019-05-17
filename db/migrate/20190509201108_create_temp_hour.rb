class CreateTempHour < ActiveRecord::Migration[5.2]
  def change
    create_table :temp_hours do |t|
      t.references :preschool
      t.datetime :opens_at
      t.datetime :closes_at
      t.boolean :closed_for_day, default: false, null: false
      t.timestamps
    end
  end
end
