class ChangeColumnFromDelivTerms < ActiveRecord::Migration[7.0]
  def change
    change_column :deliv_terms, :deliv_term, :integer
  end
end
