class CreatePreschoolUrl < ActiveRecord::Migration[5.0]
  def change
    create_table :preschool_urls do |t|
      t.integer :preschool_id
      t.string :url
      t.string :hours_element
      t.string :extras_element
      t.timestamps
    end
    add_index :preschool_urls, :preschool_id
  end
end
