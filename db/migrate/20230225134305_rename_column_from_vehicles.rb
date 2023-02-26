class RenameColumnFromVehicles < ActiveRecord::Migration[7.0]
  def change
    rename_column :vehicles, :vehicle_categories_id, :vehicle_category_id
    rename_column :vehicles, :vehicle_types_id, :vehicle_type_id
  end
end
