class CreateChanges < ActiveRecord::Migration[5.0]
  def change
    create_table :changes do |t|
      t.integer :preschool_id
      t.string :state
      t.hstore :data
      t.timestamps
    end
  end
end
