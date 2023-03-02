require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe '#valid?' do
    it 'deve ter um código' do
      vehicle_category_id = VehicleCategory.create!(category: 'Sedan médio')
      vehicle_type_id = VehicleType.create!(manufacturer_vehicle: 'GM', model_vehicle: 'Prisma')
      vehicle = Vehicle.create!(license_plate: 'HHV-0880', manufature_year: '2020', maximum_load_capacity: 500,
                                vehicle_type: vehicle_type_id, vehicle_category: vehicle_category_id)

      expect(vehicle.valid?).to be true
    end
  end
end
