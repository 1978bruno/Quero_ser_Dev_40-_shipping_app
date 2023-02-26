class RenameColumnFromDelivTerms < ActiveRecord::Migration[7.0]
  def change
    rename_column :deliv_terms, :shippings_id, :shipping_id
  end
end
