class Shipping < ApplicationRecord
  has_many :costs, class_name: 'Shipping',
                   dependent: :destroy
  has_many :deliv_terms, class_name: 'Shipping',
                         dependent: :destroy
  has_many :process_orders, class_name: 'Shipping',
                            dependent: :destroy
  has_many :orders, through: :process_orders
  has_many :vehicles, through: :process_orders
  enum status: { disabled: 0, activated: 1 }
end
