class VehicleCategory < ApplicationRecord
  validates :category, presence: true
end
