require 'rails_helper'

describe 'Usuário inicia o pedido' do
  it 'e vê as opções de modalidade disponíveis.' do
    user = User.create!(name: 'User', email: 'user1@email.com', password: 'password')
    code = allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCD12345678912')
    Order.create!(collect_zip: 11256360, collect_street: 'Rua um dois três', collect_number: 205, collect_nhood: 'Laranjeiras', collect_city: 'Condongas',
                  collect_state: 'MS', width: 10, height: 12, depth: 13, weight: 82, deliv_reipient: 'Um Dois Três de Oliveira Quatro', deliv_zip: 12365480,
                  deliv_street: 'Rua Condongueira', deliv_number: 105, deliv_nhood: 'Canelas', deliv_city: 'Jocacia', deliv_state: 'MT', km_dist: 102,
                  user:user)
    shipping1 = Shipping.create!(name: 'GP003', min_dist: 10, max_dist: 110, min_weight: 60, max_weight: 120,
                                 deliv_fee: 250.00, status: 1)
    shipping = Shipping.create!(name: 'GP004', min_dist: 111, max_dist: 180, min_weight: 26, max_weight: 86,
                                deliv_fee: 250.00, status: 0)
    Cost.create!(int_min_weight: 60, int_max_weight: 80, km_value: 0.15, shipping: shipping1)
    Cost.create!(int_min_weight: 81, int_max_weight: 100, km_value: 0.45, shipping: shipping1)
    Cost.create!(int_min_weight: 101, int_max_weight: 120, km_value: 0.75, shipping: shipping1)
    DelivTerm.create!(term_int_min_weight: 60, term_int_max_weight: 80, deliv_term: 15, shipping: shipping1)
    DelivTerm.create!(term_int_min_weight: 81, term_int_max_weight: 100, deliv_term: 45, shipping: shipping1)
    DelivTerm.create!(term_int_min_weight: 101, term_int_max_weight: 120, deliv_term: 75, shipping: shipping1)
    vehicle_category = VehicleCategory.create!(category: 'Sedan médio')
    vehicle_type = VehicleType.create!(manufacturer_vehicle: 'VW', model_vehicle: 'Jetta')
    Vehicle.create!(license_plate: 'CDD-0880', manufature_year: '2021', maximum_load_capacity: 450,
                    vehicle_type: vehicle_type, vehicle_category: vehicle_category, status: 1)


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
    click_on 'ABCD12345678912'
    click_on 'Iniciar o pedido'

    expect(page).to have_content 'ABCD12345678912'
    expect(page).to have_content 'CEP de coleta: 11256360'
    expect(page).to have_content 'Endereço de coleta: Rua um dois três, 205 - Laranjeiras Condongas - MS'
    expect(page).to have_content 'Dimensões do produto: 10cm X 12cm X 13'
    expect(page).to have_content 'Peso: 82kg'
    expect(page).to have_content 'Nome do destinatário: Um Dois Três de Oliveira Quatro'
    expect(page).to have_content 'CEP de entrega: 12365480'
    expect(page).to have_content 'Endereço de entrega: Rua Condongueira, 105 - Canelas Jocacia - MT'
    expect(page).to have_content 'Distância em KM: 102km'
    expect(page).to have_content 'Situação: pendente'
    expect(page).to have_content 'GP003'
    expect(page).to have_content 'Pedido criado por: User'
    expect(page).to have_content 'Valor do km rodado: R$ 0,45'
    expect(page).to have_content 'Valor de taxa de entrega: R$ 250'
    expect(page).to have_content 'Valor total da operação: R$ 295'
  end
  it 'e não encontra modalidade disponível' do
    user = User.create!(name: 'User', email: 'user1@email.com', password: 'password')
    code = allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCD12345678912')
    Order.create!(collect_zip: 11256360, collect_street: 'Rua um dois três', collect_number: 205, collect_nhood: 'Laranjeiras', collect_city: 'Condongas',
                  collect_state: 'MS', width: 10, height: 12, depth: 13, weight: 300, deliv_reipient: 'Um Dois Três de Oliveira Quatro', deliv_zip: 12365480,
                  deliv_street: 'Rua Condongueira', deliv_number: 105, deliv_nhood: 'Canelas', deliv_city: 'Jocacia', deliv_state: 'MT', km_dist: 102,
                  user:user)
    shipping1 = Shipping.create!(name: 'GP003', min_dist: 10, max_dist: 110, min_weight: 60, max_weight: 120,
                                 deliv_fee: 250.00, status: 1)
    shipping = Shipping.create!(name: 'GP004', min_dist: 111, max_dist: 180, min_weight: 26, max_weight: 86,
                                deliv_fee: 250.00, status: 0)
    Cost.create!(int_min_weight: 60, int_max_weight: 80, km_value: 0.15, shipping: shipping1)
    Cost.create!(int_min_weight: 81, int_max_weight: 100, km_value: 0.45, shipping: shipping1)
    Cost.create!(int_min_weight: 101, int_max_weight: 120, km_value: 0.75, shipping: shipping1)
    DelivTerm.create!(term_int_min_weight: 60, term_int_max_weight: 80, deliv_term: 15, shipping: shipping1)
    DelivTerm.create!(term_int_min_weight: 81, term_int_max_weight: 100, deliv_term: 45, shipping: shipping1)
    DelivTerm.create!(term_int_min_weight: 101, term_int_max_weight: 120, deliv_term: 75, shipping: shipping1)
    vehicle_category = VehicleCategory.create!(category: 'Sedan médio')
    vehicle_type = VehicleType.create!(manufacturer_vehicle: 'VW', model_vehicle: 'Jetta')
    Vehicle.create!(license_plate: 'CDD-0880', manufature_year: '2021', maximum_load_capacity: 450,
                    vehicle_type: vehicle_type, vehicle_category: vehicle_category, status: 1)

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
    click_on 'ABCD12345678912'
    click_on 'Iniciar o pedido'

    expect(page).to have_content 'Sem cadastro de modalidade de transporte'
  end
  it 'e encontra modalidade sem valor de operação - custo' do
    user = User.create!(name: 'User', email: 'user1@email.com', password: 'password')
    code = allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCD12345678912')
    Order.create!(collect_zip: 11256360, collect_street: 'Rua um dois três', collect_number: 205, collect_nhood: 'Laranjeiras', collect_city: 'Condongas',
                  collect_state: 'MS', width: 10, height: 12, depth: 13, weight: 82, deliv_reipient: 'Um Dois Três de Oliveira Quatro', deliv_zip: 12365480,
                  deliv_street: 'Rua Condongueira', deliv_number: 105, deliv_nhood: 'Canelas', deliv_city: 'Jocacia', deliv_state: 'MT', km_dist: 102,
                  user:user, status: 0)
    shipping1 = Shipping.create!(name: 'GP003', min_dist: 10, max_dist: 110, min_weight: 60, max_weight: 120,
                                 deliv_fee: 250, status: 1)
    DelivTerm.create!(term_int_min_weight: 60, term_int_max_weight: 80, deliv_term: 0.15, shipping: shipping1)
    DelivTerm.create!(term_int_min_weight: 81, term_int_max_weight: 100, deliv_term: 0.45, shipping: shipping1)
    DelivTerm.create!(term_int_min_weight: 101, term_int_max_weight: 120, deliv_term: 0.75, shipping: shipping1)
    vehicle_category = VehicleCategory.create!(category: 'Sedan médio')
    vehicle_type = VehicleType.create!(manufacturer_vehicle: 'VW', model_vehicle: 'Jetta')
    Vehicle.create!(license_plate: 'CDD-0880', manufature_year: '2021', maximum_load_capacity: 450,
                    vehicle_type: vehicle_type, vehicle_category: vehicle_category, status: 1)

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
    click_on 'ABCD12345678912'
    click_on 'Iniciar o pedido'

    expect(page).to have_content 'ABCD12345678912'
    expect(page).to have_content 'CEP de coleta: 11256360'
    expect(page).to have_content 'Endereço de coleta: Rua um dois três, 205 - Laranjeiras Condongas - MS'
    expect(page).to have_content 'Dimensões do produto: 10cm X 12cm X 13'
    expect(page).to have_content 'Peso: 82kg'
    expect(page).to have_content 'Nome do destinatário: Um Dois Três de Oliveira Quatro'
    expect(page).to have_content 'CEP de entrega: 12365480'
    expect(page).to have_content 'Endereço de entrega: Rua Condongueira, 105 - Canelas Jocacia - MT'
    expect(page).to have_content 'Distância em KM: 102km'
    expect(page).to have_content 'Situação: pendente'
    expect(page).to have_content 'GP003'
    expect(page).to have_content 'Pedido criado por: User'
    expect(page).to have_content 'Custo do KM rodado não cadastrado'
    expect(page).not_to have_content 'iniciar entrega'
  end
  it 'e encontra modalidade sem valor de operação - prazo' do
    user = User.create!(name: 'User', email: 'user1@email.com', password: 'password')
    code = allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCD12345678912')
    Order.create!(collect_zip: 11256360, collect_street: 'Rua um dois três', collect_number: 205, 
                collect_nhood: 'Laranjeiras', collect_city: 'Condongas', collect_state: 'MS', width: 10, height: 12,
                depth: 13, weight: 82, deliv_reipient: 'Um Dois Três de Oliveira Quatro', deliv_zip: 12_365_480,
                  deliv_street: 'Rua Condongueira', deliv_number: 105, deliv_nhood: 'Canelas', deliv_city: 'Jocacia', 
                  deliv_state: 'MT', km_dist: 102, user: user, status: 0)
    shipping1 = Shipping.create!(name: 'GP003', min_dist: 10, max_dist: 110, min_weight: 60, max_weight: 120,
                                 deliv_fee: 250.00, status: 1)
    Cost.create!(int_min_weight: 60, int_max_weight: 80, km_value: 0.15, shipping: shipping1)
    Cost.create!(int_min_weight: 81, int_max_weight: 100, km_value: 0.45, shipping: shipping1)
    Cost.create!(int_min_weight: 101, int_max_weight: 120, km_value: 0.75, shipping: shipping1)
    vehicle_category = VehicleCategory.create!(category: 'Sedan médio')
    vehicle_type = VehicleType.create!(manufacturer_vehicle: 'VW', model_vehicle: 'Jetta')
    Vehicle.create!(license_plate: 'CDD-0880', manufature_year: '2021', maximum_load_capacity: 450,
                    vehicle_type: vehicle_type, vehicle_category: vehicle_category, status: 1)

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
    click_on 'ABCD12345678912'
    click_on 'Iniciar o pedido'

    expect(page).to have_content 'ABCD12345678912'
    expect(page).to have_content 'CEP de coleta: 11256360'
    expect(page).to have_content 'Endereço de coleta: Rua um dois três, 205 - Laranjeiras Condongas - MS'
    expect(page).to have_content 'Dimensões do produto: 10cm X 12cm X 13'
    expect(page).to have_content 'Peso: 82kg'
    expect(page).to have_content 'Nome do destinatário: Um Dois Três de Oliveira Quatro'
    expect(page).to have_content 'CEP de entrega: 12365480'
    expect(page).to have_content 'Endereço de entrega: Rua Condongueira, 105 - Canelas Jocacia - MT'
    expect(page).to have_content 'Distância em KM: 102km'
    expect(page).to have_content 'Situação: pendente'
    expect(page).to have_content 'GP003'
    expect(page).to have_content 'Prazo de entrega não cadastrado'
    expect(page).not_to have_content 'iniciar entrega'
  end
  it 'e encontra modalidade sem veículo de transporte disponível' do
    user = User.create!(name: 'User', email: 'user1@email.com', password: 'password')
    code = allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCD12345678912')
    Order.create!(collect_zip: 11256360, collect_street: 'Rua um dois três', collect_number: 205,
                collect_nhood: 'Laranjeiras', collect_city: 'Condongas', collect_state: 'MS', width: 10, height: 12,
                depth: 13, weight: 82, deliv_reipient: 'Um Dois Três de Oliveira Quatro', deliv_zip: 12365480,
                  deliv_street: 'Rua Condongueira', deliv_number: 105, deliv_nhood: 'Canelas', deliv_city: 'Jocacia', 
                  deliv_state: 'MT', km_dist: 102, user:user, status: 0)
    shipping1 = Shipping.create!(name: 'GP003', min_dist: 10, max_dist: 110, min_weight: 60, max_weight: 120,
                                 deliv_fee: 250.00, status: 1)
    Cost.create!(int_min_weight: 60, int_max_weight: 80, km_value: 0.15, shipping: shipping1)
    Cost.create!(int_min_weight: 81, int_max_weight: 100, km_value: 0.45, shipping: shipping1)
    Cost.create!(int_min_weight: 101, int_max_weight: 120, km_value: 0.75, shipping: shipping1)
    DelivTerm.create!(term_int_min_weight: 60, term_int_max_weight: 80, deliv_term: 0.15, shipping: shipping1)
    DelivTerm.create!(term_int_min_weight: 81, term_int_max_weight: 100, deliv_term: 0.45, shipping: shipping1)
    DelivTerm.create!(term_int_min_weight: 101, term_int_max_weight: 120, deliv_term: 0.75, shipping: shipping1)

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
    click_on 'ABCD12345678912'
    click_on 'Iniciar o pedido'

    expect(page).to have_content 'ABCD12345678912'
    expect(page).to have_content 'CEP de coleta: 11256360'
    expect(page).to have_content 'Endereço de coleta: Rua um dois três, 205 - Laranjeiras Condongas - MS'
    expect(page).to have_content 'Dimensões do produto: 10cm X 12cm X 13'
    expect(page).to have_content 'Peso: 82kg'
    expect(page).to have_content 'Nome do destinatário: Um Dois Três de Oliveira Quatro'
    expect(page).to have_content 'CEP de entrega: 12365480'
    expect(page).to have_content 'Endereço de entrega: Rua Condongueira, 105 - Canelas Jocacia - MT'
    expect(page).to have_content 'Distância em KM: 102km'
    expect(page).to have_content 'Situação: pendente'
    expect(page).to have_content 'GP003'
    expect(page).to have_content 'Transporte não disponível'
    expect(page).not_to have_content 'iniciar entrega'
  end
end
