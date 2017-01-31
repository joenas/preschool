class RenameChanges < ActiveRecord::Migration[5.0]
  def change
    rename_table :changes, :site_changes
  end
end
