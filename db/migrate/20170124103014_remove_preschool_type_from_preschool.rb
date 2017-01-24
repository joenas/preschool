class RemovePreschoolTypeFromPreschool < ActiveRecord::Migration[5.0]
  def change
    remove_column :preschools, :preschool_type, :string
  end
end
