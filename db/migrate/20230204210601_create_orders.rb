class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :code
      t.string :collect_street
      t.integer :collect_number
      t.string :collect_nhood
      t.string :collect_city
      t.string :collect_state
      t.integer :width
      t.integer :height
      t.integer :depth
      t.integer :weight
      t.string :deliv_reipient
      t.string :deliv_street
      t.integer :deliv_number
      t.string :deliv_nhood
      t.string :deliv_city
      t.string :deliv_state
      t.integer :km_dist
      t.integer :deliv_zip
      t.integer :collect_zip
      t.integer :status, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
