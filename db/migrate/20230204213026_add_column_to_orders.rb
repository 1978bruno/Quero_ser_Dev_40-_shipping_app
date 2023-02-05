class AddColumnToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :deliv_zip, :integer
    add_column :orders, :collect_zip, :integer
  end
end
