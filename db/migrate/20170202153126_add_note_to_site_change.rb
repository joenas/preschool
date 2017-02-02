class AddNoteToSiteChange < ActiveRecord::Migration[5.0]
  def change
    add_column :site_changes, :note, :string
  end
end
