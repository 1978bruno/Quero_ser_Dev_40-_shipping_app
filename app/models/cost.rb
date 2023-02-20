class Cost < ApplicationRecord
  belongs_to :shipping

  validates :int_min_weight, :int_max_weight, :km_value, presence: true
end
