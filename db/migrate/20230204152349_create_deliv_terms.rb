class CreateDelivTerms < ActiveRecord::Migration[7.0]
  def change
    create_table :deliv_terms do |t|
      t.integer :term_int_min_weight
      t.integer :term_int_max_weight
      t.float :deliv_term
      t.references :shippings, null: false, foreign_key: true

      t.timestamps
    end
  end
end
