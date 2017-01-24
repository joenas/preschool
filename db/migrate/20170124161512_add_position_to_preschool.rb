class AddPositionToPreschool < ActiveRecord::Migration[5.0]
  def change
    add_column :preschools, :position, :point
    add_index :preschools, :position, using: :gist
  end
end
