class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :license_plate
      t.references :vehicle_types, null: false, foreign_key: true
      t.references :vehicle_categories, null: false, foreign_key: true
      t.integer :manufature_year
      t.integer :maximum_load_capacity
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
