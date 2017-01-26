class AddTimeStampsToHour < ActiveRecord::Migration[5.0]
  def change
    add_column :hours, :created_at, :datetime
    add_column :hours, :updated_at, :datetime
  end
end
