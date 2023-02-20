require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe '#valid?' do
    it 'deve ter um código' do
      vehicle_category = VehicleCategory.create!(category: 'Sedan médio')
      vehicle_type = VehicleType.create!(manufacturer_vehicle: 'GM', model_vehicle: 'Prisma')
      vehicle = Vehicle.create!(license_plate: 'HHV-0880', manufature_year: '2020', maximum_load_capacity: 500,
                                vehicle_types_id: vehicle_category.id, vehicle_categories_id: vehicle_type.id)

      expect(vehicle.valid?).to be true
    end
  end
end
