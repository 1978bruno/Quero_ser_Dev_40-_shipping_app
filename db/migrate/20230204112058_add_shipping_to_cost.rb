class AddShippingToCost < ActiveRecord::Migration[7.0]
  def change
    add_reference :costs, :shipping, null: false, foreign_key: true
  end
end
