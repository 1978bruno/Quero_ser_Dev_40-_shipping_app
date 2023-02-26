class CreateCosts < ActiveRecord::Migration[7.0]
  def change
    create_table :costs do |t|
      t.integer :int_min_weight
      t.integer :int_max_weight
      t.float :km_value
      t.references :shippings, null: false, foreign_key: true

      t.timestamps
    end
  end
end
