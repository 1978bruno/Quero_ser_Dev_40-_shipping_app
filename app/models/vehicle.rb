class Vehicle < ApplicationRecord
  enum status: {disabled: 0, activated: 1}

  validates :license_plate, :manufature_year, :maximum_load_capacity, presence: true
end
