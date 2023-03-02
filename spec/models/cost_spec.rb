require 'rails_helper'

RSpec.describe Cost, type: :model do
  describe '#valid?' do
    it 'deve ter um código' do
      shipping = Shipping.create!(name: 'Rio', min_dist: 60, max_dist: 120, min_weight: 200, max_weight: 800,
                                  deliv_fee: 250)
      cost = Cost.create!(int_min_weight: 25, int_max_weight: 80, km_value: 0.15, shipping_id: shipping.id)

      expect(cost.valid?).to be true
      expect(cost.int_min_weight).to eq 25
      expect(cost.int_max_weight).to eq 80
      expect(cost.km_value).to eq 0.15
      expect(cost.shipping).to eq shipping
      expect(cost.shipping.name).to eq 'Rio'
      expect(cost.shipping.status).to eq 'disabled'
    end
  end
end
