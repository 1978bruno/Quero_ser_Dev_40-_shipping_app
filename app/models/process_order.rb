class ProcessOrder < ApplicationRecord
  belongs_to :order
  belongs_to :shipping
  belongs_to :vehicle

  validates :shipping_id, :vehicle_id, presence: false
end
