class AddTimeStampsToPreschool < ActiveRecord::Migration[5.0]
  def change
    add_column :preschools, :created_at, :datetime
    add_column :preschools, :updated_at, :datetime
  end
end
