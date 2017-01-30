class AddMissingIndicies < ActiveRecord::Migration[5.0]
  def change
    add_index :changes, :preschool_id
    add_index :hours, :preschool_id
    add_index :hours, :day_of_week
  end
end
