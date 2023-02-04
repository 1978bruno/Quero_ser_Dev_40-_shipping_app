class Shipping < ApplicationRecord
  enum status: {disabled: 0, activated: 1}
  has_one :cost

end
