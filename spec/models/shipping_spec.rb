require 'rails_helper'

RSpec.describe Shipping, type: :model do
  describe '#valid?' do
    it 'deve ter um código' do
      shipping = Shipping.create!(name: 'Maceio', min_dist: 70, max_dist: 200, min_weight: 100, max_weight: 500,
                                  deliv_fee: 1000, status: 1)

      expect(shipping.valid?).to be true
      expect(shipping.name).to eq 'Maceio'
      expect(shipping.min_dist).to eq 70
      expect(shipping.max_dist).to eq 200
      expect(shipping.min_weight).to eq 100
      expect(shipping.max_weight).to eq 500
      expect(shipping.deliv_fee).to eq 1000
      expect(shipping.status).to eq 'activated'
    end
  end
end
