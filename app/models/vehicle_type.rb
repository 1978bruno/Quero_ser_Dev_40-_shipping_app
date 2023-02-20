class VehicleType < ApplicationRecord
  validates :manufacturer_vehicle, :model_vehicle, presence: true
end
