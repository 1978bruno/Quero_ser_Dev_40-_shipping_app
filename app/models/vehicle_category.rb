class VehicleCategory < ApplicationRecord
  has_many :vehicles, class_name: 'Shipping',
                      dependent: :destroy
  validates :category, presence: true
end
