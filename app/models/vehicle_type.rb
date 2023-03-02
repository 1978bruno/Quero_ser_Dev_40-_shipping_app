class VehicleType < ApplicationRecord
  has_many :vehicles, class_name: 'VeicleType',
                      dependent: :destroy
  validates :manufacturer_vehicle, :model_vehicle, presence: true
end
