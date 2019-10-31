class AddErrorOnCheckToPreschoolUrl < ActiveRecord::Migration[5.2]
  def change
    add_column :preschool_urls, :error_on_check, :boolean, default: false, null: false
  end
end
