require 'rails_helper'

RSpec.describe VehicleCategory, type: :model do
  describe '#valid?' do
    it 'deve ter um código' do
      vehicle_category = VehicleCategory.create!(category: 'Sedan médio')

      expect(vehicle_category.valid?).to be true
      expect(vehicle_category.category).to eq 'Sedan médio'
    end
  end
end
