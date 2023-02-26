class CreateProcessOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :process_orders do |t|
      t.references :order, null: false, foreign_key: true
      t.references :shipping, null: false, foreign_key: true
      t.references :vehicle, null: false, foreign_key: true
      t.float :total_cost

      t.timestamps
    end
  end
end
