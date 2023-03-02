require 'rails_helper'

RSpec.describe ProcessOrder, type: :model do
  describe '#valid?' do
    it 'deve ter um código' do
      user_id = User.create(name: 'User', email: 'user@email.com', password: 'pwd123456')
      order_id = Order.create!(collect_zip: 11_256_360, collect_street: 'Rua um dois três', collect_number: 205,
                               collect_nhood: 'Laranjeiras', collect_city: 'Condongas', collect_state: 'MS', width: 10,
                               height: 12, depth: 13, weight: 82, deliv_reipient: 'Um Dois Três de Oliveira Quatro',
                               deliv_zip: 12_365_480, deliv_street: 'Rua Condongueira', deliv_number: 105,
                               deliv_nhood: 'Canelas', deliv_city: 'Jocacia', deliv_state: 'MT', km_dist: 102,
                               user: user_id)
      shipping_id = Shipping.create!(name: 'GP003', min_dist: 10, max_dist: 110, min_weight: 60, max_weight: 120,
                                     deliv_fee: 250, status: 1)
      Cost.create!(int_min_weight: 60, int_max_weight: 85, km_value: 0.15, shipping: shipping_id)
      DelivTerm.create!(term_int_min_weight: 60, term_int_max_weight: 85, deliv_term: 15, shipping: shipping_id)
      vehicle_category_id = VehicleCategory.create!(category: 'Sedan médio')
      vehicle_type_id = VehicleType.create!(manufacturer_vehicle: 'VW', model_vehicle: 'Jetta')
      vehicle_id = Vehicle.create!(license_plate: 'CDD-0880', manufature_year: '2021', maximum_load_capacity: 450,
                                   vehicle_type: vehicle_type_id, vehicle_category: vehicle_category_id, status: 1)
      process_order = ProcessOrder.create!(shipping: shipping_id, order: order_id, vehicle: vehicle_id,
                                           total_cost: 320.09)

      expect(process_order.valid?).to be true
      expect(process_order.order.collect_zip).to eq 11_256_360
      expect(process_order.shipping.name).to eq 'GP003'
      expect(process_order.vehicle.license_plate).to eq 'CDD-0880'
      expect(process_order.total_cost).to eq 320.09
      expect(process_order.vehicle.vehicle_type.model_vehicle).to eq 'Jetta'
      expect(process_order.vehicle.vehicle_category.category).to eq 'Sedan médio'
    end
  end
end
