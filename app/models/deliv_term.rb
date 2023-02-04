class DelivTerm < ApplicationRecord
  belongs_to :shipping

  validates :term_int_min_weight, :term_int_max_weight, :deliv_term, presence: true
end
