class Shipping < ApplicationRecord
  enum status: {disabled: 0, activated: 1}
  has_many :costs
  has_many :deliv_terms

end
