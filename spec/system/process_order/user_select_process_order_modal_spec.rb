require 'rails_helper'

describe 'Usuário inicia uma ordem' do
  it 'a partir de uma ordem pendentes' do
    user = User.create(name: 'User', email: 'user1@email.com', password: 'password')
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCD12345678912')
    Order.create!(collect_zip: 11_256_360, collect_street: 'Rua um dois três', collect_number: 205,
                  collect_nhood: 'Laranjeiras', collect_city: 'Condongas', collect_state: 'MS',
                  width: 10, height: 12, depth: 13, weight: 82, deliv_reipient: 'Um Dois Três de Oliveira Quatro',
                  deliv_zip: 12_365_480, deliv_street: 'Rua Condongueira', deliv_number: 105, deliv_nhood: 'Canelas',
                  deliv_city: 'Jocacia', deliv_state: 'MT', km_dist: 102, user_id: user.id, status: 0)
    shipping2 = Shipping.create!(name: 'GP004', min_dist: 111, max_dist: 180, min_weight: 60, max_weight: 85,
                                 deliv_fee: 150, status: 1)
    Cost.create!(int_min_weight: 81, int_max_weight: 100, km_value: 0.45, shipping: shipping2)
    DelivTerm.create!(term_int_min_weight: 81, term_int_max_weight: 100, deliv_term: 45, shipping: shipping2)
    vehicle_category_id = VehicleCategory.create!(category: 'Sedan médio')
    vehicle_type_id = VehicleType.create!(manufacturer_vehicle: 'VW', model_vehicle: 'Jetta')
    Vehicle.create!(license_plate: 'CDD-0880', manufature_year: '2021', maximum_load_capacity: 450,
                    vehicle_type: vehicle_type_id, vehicle_category: vehicle_category_id, status: 1)

    visit root_path
    login_as(user)
    click_on 'Cotação'
    click_on 'Orçamento'
    click_on 'ABCD12345678912'
    click_on 'Iniciar o pedido'
    click_on 'iniciar entrega', id: 'GP004'

    expect(page).to have_content 'Código identificador: ABCD12345678912'
    expect(page).to have_content 'GP004'
    expect(page).to have_content 'Situação: em entrega'
    expect(page).to have_content 'VW - Jetta - 2021'
    expect(page).to have_content 'Situação: em entrega'
    expect(page).to have_content 'Valor total da operação: R$ 195,90'
    expect(page).to have_content 'Tempo total da operação: 45dias'
  end
end
