class CreatePreschool < ActiveRecord::Migration[5.0]
  def change
    create_table :preschools do |t|
      t.string :preschool_type
      t.string :name
      t.string :url
      t.string :street_name
      t.string :postal_code
      t.string :city
      t.string :note
    end
  end
end
