class RenameColumnFromCosts < ActiveRecord::Migration[7.0]
  def change
    rename_column :costs, :shippings_id, :shipping_id
  end
end
