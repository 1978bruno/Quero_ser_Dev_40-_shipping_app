class CreateCosts < ActiveRecord::Migration[7.0]
  def change
    create_table :costs do |t|
      t.integer :int_min_weight
      t.integer :int_max_weight
      t.integer :km_value

      t.timestamps
    end
  end
end
