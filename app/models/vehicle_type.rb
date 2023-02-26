class VehicleType < ApplicationRecord
  has_many :vehicles
  validates :manufacturer_vehicle, :model_vehicle, presence: true
end
