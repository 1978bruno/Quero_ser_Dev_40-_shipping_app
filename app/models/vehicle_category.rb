class VehicleCategory < ApplicationRecord
  has_many :vehicles
  validates :category, presence: true
end
