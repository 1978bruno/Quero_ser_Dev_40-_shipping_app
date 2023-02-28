# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create(name: 'User', email: 'user@email.com', password: 'pwd123456')
Order.create!(collect_zip: 11_256_360, collect_street: 'Rua um dois três', collect_number: 205, collect_nhood: 'Laranjeiras', collect_city: 'Condongas',
              collect_state: 'MS', width: 10, height: 12, depth: 13, weight: 82, deliv_reipient: 'Um Dois Três de Oliveira Quatro', deliv_zip: 12_365_480,
              deliv_street: 'Rua Condongueira', deliv_number: 105, deliv_nhood: 'Canelas', deliv_city: 'Jocacia', deliv_state: 'MT', km_dist: 102,
              user_id: 1, status: 0)
Shipping.create!(name: 'GP003', min_dist: 10, max_dist: 110, min_weight: 60, max_weight: 120,
                             deliv_fee: 250)
Shipping.create!(name: 'GP004', min_dist: 111, max_dist: 180, min_weight: 60, max_weight: 85,
                             deliv_fee: 150)
Shipping.create!(name: 'GP005', min_dist: 111, max_dist: 180, min_weight: 80, max_weight: 85,
                             deliv_fee: 100)
Cost.create!(int_min_weight: 60, int_max_weight: 70, km_value: 0.15, shipping_id: 1)
Cost.create!(int_min_weight: 71, int_max_weight: 80, km_value: 0.45, shipping_id: 1)
Cost.create!(int_min_weight: 81, int_max_weight: 85, km_value: 0.75, shipping_id: 1)
DelivTerm.create!(term_int_min_weight: 60, term_int_max_weight: 70, deliv_term: 15, shipping_id: 1)
DelivTerm.create!(term_int_min_weight: 71, term_int_max_weight: 80, deliv_term: 45, shipping_id: 1)
DelivTerm.create!(term_int_min_weight: 80, term_int_max_weight: 85, deliv_term: 75, shipping_id: 1)
Cost.create!(int_min_weight: 60, int_max_weight: 70, km_value: 0.25, shipping_id: 2)
Cost.create!(int_min_weight: 71, int_max_weight: 80, km_value: 0.65, shipping_id: 2)
Cost.create!(int_min_weight: 81, int_max_weight: 85, km_value: 0.95, shipping_id: 2)
DelivTerm.create!(term_int_min_weight: 60, term_int_max_weight: 70, deliv_term: 25, shipping_id: 2)
DelivTerm.create!(term_int_min_weight: 71, term_int_max_weight: 80, deliv_term: 55, shipping_id: 2)
DelivTerm.create!(term_int_min_weight: 81, term_int_max_weight: 85, deliv_term: 85, shipping_id: 2)
Cost.create!(int_min_weight: 60, int_max_weight: 70, km_value: 0.35, shipping_id: 3)
Cost.create!(int_min_weight: 71, int_max_weight: 80, km_value: 0.55, shipping_id: 3)
Cost.create!(int_min_weight: 81, int_max_weight: 85, km_value: 1.05, shipping_id: 3)
DelivTerm.create!(term_int_min_weight: 60, term_int_max_weight: 70, deliv_term: 35, shipping_id: 3)
DelivTerm.create!(term_int_min_weight: 71, term_int_max_weight: 80, deliv_term: 65, shipping_id: 3)
DelivTerm.create!(term_int_min_weight: 81, term_int_max_weight: 85, deliv_term: 95, shipping_id: 3)
VehicleCategory.create!(category: 'Sedan médio')
VehicleType.create!(manufacturer_vehicle: 'GM', model_vehicle: 'Prisma')
Vehicle.create!(license_plate: 'HHV-0880', manufature_year: '2020', maximum_load_capacity: 500,
                vehicle_type_id: 1, vehicle_category_id: 1)
VehicleCategory.create!(category: 'Sedan grande')
VehicleType.create!(manufacturer_vehicle: 'VW', model_vehicle: 'Jetta')
Vehicle.create!(license_plate: 'CDD-0880', manufature_year: '2021', maximum_load_capacity: 450,
                vehicle_type_id: 2, vehicle_category_id: 2)
VehicleCategory.create!(category: 'PickUp pequena')
VehicleType.create!(manufacturer_vehicle: 'FIAT', model_vehicle: 'Strada')
Vehicle.create!(license_plate: 'LCO-8008', manufature_year: '2020', maximum_load_capacity: 800,
                vehicle_type_id: 3, vehicle_category_id: 3)
VehicleCategory.create!(category: 'PickUp grande')
VehicleType.create!(manufacturer_vehicle: 'VW', model_vehicle: 'Amarok')
Vehicle.create!(license_plate: 'KTO-8I08', manufature_year: '2022', maximum_load_capacity: 1500,
                vehicle_type_id: 4, vehicle_category_id: 4)

#      shipping1 = Shipping.create!(name: 'GP003', min_dist: 10, max_dist: 110, min_weight: 60, max_weight: 120,
#                                  deliv_fee: 250)
#      shipping0 = Shipping.create!(name: 'GP004', min_dist: 111, max_dist: 180, min_weight: 60, max_weight: 85,
#                                  deliv_fee: 150)
#      shipping2 = Shipping.create!(name: 'GP005', min_dist: 111, max_dist: 180, min_weight: 80, max_weight: 85,
#                                  deliv_fee: 100)
#      Cost.create!(int_min_weight: 60, int_max_weight: 85, km_value: 15, shipping: shipping0)
#      Cost.create!(int_min_weight: 81, int_max_weight: 100, km_value: 45, shipping: shipping1)
#      Cost.create!(int_min_weight: 80, int_max_weight: 85, km_value: 75, shipping: shipping2)
#      DelivTerm.create!(term_int_min_weight: 60, term_int_max_weight: 85, deliv_term: 15, shipping: shipping0)
#      DelivTerm.create!(term_int_min_weight: 81, term_int_max_weight: 100, deliv_term: 45, shipping: shipping1)
#      DelivTerm.create!(term_int_min_weight: 80, term_int_max_weight: 85, deliv_term: 75, shipping: shipping2)
#      vehicle_category = VehicleCategory.create!(category: 'Sedan médio')
#      Vehicle.create!(license_plate: 'HHV-0880', manufature_year: '2020', maximum_load_capacity: 500,
#                      vehicle_type: vehicle_type, vehicle_category: vehicle_category)
#      vehicle_category1 = VehicleCategory.create!(category: 'Sedan médio')
#      vehicle_type1 = VehicleType.create!(manufacturer_vehicle: 'VW', model_vehicle: 'Jetta')
#      Vehicle.create!(license_plate: 'CDD-0880', manufature_year: '2021', maximum_load_capacity: 450,
#                    vehicle_type: vehicle_type1, vehicle_category: vehicle_category1)
#      vehicle_category2 = VehicleCategory.create!(category: 'PickUp pequena')
#      vehicle_type2 = VehicleType.create!(manufacturer_vehicle: 'FIAT', model_vehicle: 'Strada')
#      Vehicle.create!(license_plate: 'LCO-8008', manufature_year: '2020', maximum_load_capacity: 800,
#                      vehicle_type: vehicle_type2, vehicle_category: vehicle_category2)
