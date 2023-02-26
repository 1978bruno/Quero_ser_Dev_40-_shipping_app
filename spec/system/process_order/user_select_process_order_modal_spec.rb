require 'rails_helper'

describe 'Usuário lista as Ordens abertas no sistema' do
  it 'com ordens pendentes' do
    user = User.create(name: 'User', email: 'user1@email.com', password: 'password')
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCD12345678912')
    Order.create!(collect_zip: 11256360, collect_street: 'Rua um dois três', collect_number: 205, collect_nhood: 'Laranjeiras', collect_city: 'Condongas',
                  collect_state: 'MS', width: 10, height: 12, depth: 13, weight: 82, deliv_reipient: 'Um Dois Três de Oliveira Quatro', deliv_zip: 12365480,
                  deliv_street: 'Rua Condongueira', deliv_number: 105, deliv_nhood: 'Canelas', deliv_city: 'Jocacia', deliv_state: 'MT', km_dist: 102,
                  user_id: user.id, status: 0)
    shipping1 = Shipping.create!(name: 'GP003', min_dist: 10, max_dist: 110, min_weight: 60, max_weight: 120,
                                 deliv_fee: 250)
    shipping2 = Shipping.create!(name: 'GP004', min_dist: 111, max_dist: 180, min_weight: 60, max_weight: 85,
                                 deliv_fee: 150)
    shipping3 = Shipping.create!(name: 'GP005', min_dist: 111, max_dist: 180, min_weight: 80, max_weight: 85,
                                 deliv_fee: 100)
    Cost.create!(int_min_weight: 60, int_max_weight: 85, km_value: 15, shipping: shipping1)
    Cost.create!(int_min_weight: 81, int_max_weight: 100, km_value: 45, shipping: shipping2)
    Cost.create!(int_min_weight: 80, int_max_weight: 85, km_value: 75, shipping: shipping2)
    DelivTerm.create!(term_int_min_weight: 60, term_int_max_weight: 85, deliv_term: 15, shipping: shipping1)
    DelivTerm.create!(term_int_min_weight: 81, term_int_max_weight: 100, deliv_term: 45, shipping: shipping2)
    DelivTerm.create!(term_int_min_weight: 80, term_int_max_weight: 85, deliv_term: 75, shipping: shipping3)
    vehicle_category = VehicleCategory.create!(category: 'Sedan médio')
    vehicle_type = VehicleType.create!(manufacturer_vehicle: 'GM', model_vehicle: 'Prisma')
    Vehicle.create!(license_plate: 'HHV-0880', manufature_year: '2020', maximum_load_capacity: 500,
                    vehicle_type: vehicle_type, vehicle_category: vehicle_category)
    vehicle_category1 = VehicleCategory.create!(category: 'Sedan médio')
    vehicle_type1 = VehicleType.create!(manufacturer_vehicle: 'VW', model_vehicle: 'Jetta')
    Vehicle.create!(license_plate: 'CDD-0880', manufature_year: '2021', maximum_load_capacity: 450,
                    vehicle_type: vehicle_type1, vehicle_category: vehicle_category1)
    vehicle_category2 = VehicleCategory.create!(category: 'PickUp pequena')
    vehicle_type2 = VehicleType.create!(manufacturer_vehicle: 'FIAT', model_vehicle: 'Strada')
    Vehicle.create!(license_plate: 'LCO-8008', manufature_year: '2020', maximum_load_capacity: 800,
                    vehicle_type: vehicle_type2, vehicle_category: vehicle_category2)

    visit root_path
    within('nav') do
      click_on 'Entrar'
    end
    within('form') do
      fill_in 'E-mail', with: 'user1@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    click_on 'Cotação'
    click_on 'Orçamento'
    click_on 'ABCD12345678912'
    within('main') do
      click_on 'Iniciar o pedido'
    end
    expect(page).to have_content 'Código identificador: ABCD12345678912'
    expect(page).to have_content 'GP004'
    expect(page).to have_content 'Situação: em entrega'
    expect(page).to have_content 'Veiculo selecionado: VW - Jetta - 2021'
    expect(page).to have_content 'Situação: em uso'
    expect(page).to have_content 'Valor total da operação: R$ 295,00'
    expect(page).to have_content 'Prazo total da operação: 15 dias'
  end
end
