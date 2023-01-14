class CreateShippings < ActiveRecord::Migration[7.0]
  def change
    create_table :shippings do |t|
      t.string :name
      t.integer :min_dist
      t.integer :max_dist
      t.integer :min_weight
      t.integer :max_weight
      t.integer :deliv_fee

      t.timestamps
    end
  end
end
