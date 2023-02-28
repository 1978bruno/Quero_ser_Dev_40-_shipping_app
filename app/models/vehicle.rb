class Vehicle < ApplicationRecord
  belongs_to :vehicle_category
  belongs_to :vehicle_type
  has_many :process_orders
  has_many :orders, :through => :process_orders
  has_many :shippings, :through => :process_orders
  enum status: { disabled: 0, activated: 1, in_use: 2 }

  validates :license_plate, :manufature_year, :maximum_load_capacity, :vehicle_category_id, :vehicle_type_id, :status, presence: true

end
