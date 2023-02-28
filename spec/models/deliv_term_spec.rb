require 'rails_helper'

RSpec.describe DelivTerm, type: :model do
  describe '#valid?' do
    it 'deve ter um código' do
      shipping = Shipping.create!(name: 'Rio', min_dist: 60, max_dist: 120, min_weight: 200, max_weight: 800,
                                   deliv_fee: 250)
      deliv_term = DelivTerm.create!(term_int_min_weight: 125, term_int_max_weight: 150, deliv_term: 15, shipping: shipping)

      expect(deliv_term.valid?).to be true
      expect(deliv_term.term_int_min_weight).to eq 125
      expect(deliv_term.term_int_max_weight).to eq 150
      expect(deliv_term.deliv_term).to eq 15
      expect(deliv_term.shipping).to eq shipping
      expect(deliv_term.shipping.name).to eq 'Rio'
      expect(deliv_term.shipping.status).to eq 'disabled'
    end
  end
end
