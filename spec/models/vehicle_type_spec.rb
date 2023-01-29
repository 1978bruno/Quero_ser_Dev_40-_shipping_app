require 'rails_helper'

RSpec.describe VehicleType, type: :model do
  describe '#valid?' do
    it 'deve ter um código' do
      vehicle_type = VehicleType.create!(manufacturer_vehicle: 'GM', model_vehicle: 'Prisma')

      expect(vehicle_type.valid?).to be true
      expect(vehicle_type.manufacturer_vehicle).to eq 'GM'
      expect(vehicle_type.model_vehicle).to eq 'Prisma'
    end
  end
end
