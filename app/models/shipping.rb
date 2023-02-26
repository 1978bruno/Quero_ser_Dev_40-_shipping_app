class Shipping < ApplicationRecord
  has_many :costs
  has_many :deliv_terms
  has_many :process_orders
  has_many :orders, :through => :process_orders
  has_many :vehicles, :through => :process_orders
  enum status: { disabled: 0, activated: 1 }
end
