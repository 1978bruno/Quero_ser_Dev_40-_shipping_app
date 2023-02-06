require 'rails_helper'

describe 'Usuário lista as Ordens abertas no sistema' do
  it 'sem resultados a serem apresentados' do

    visit root_path
    click_on ('Cotação')

    expect(page).to have_content 'Lista de pedidos em aberto'
    expect(page).to have_content 'Nenhum veículo cadastrado'
  end
  it 'com ordens pendentes' do
    user = User.create!(name: 'Bruno', email:'bruno@email.com', password:'password')
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCD12345678912')
    Order.create!(collect_zip: 11256360, collect_street: 'Rua um dois três', collect_number: 205, collect_nhood: 'Laranjeiras', collect_city: 'Condongas', 
                  collect_state: 'MS', width: 10, height: 12, depth: 13, weight: 20, deliv_reipient: 'Um Dois Três de Oliveira Quatro', deliv_zip: 12365480, 
                  deliv_street: 'Rua Condongueira', deliv_number: 105 , deliv_nhood: 'Canelas', deliv_city: 'Jocacia', deliv_state: 'MT', km_dist: 320, 
                  user_id: user.id, status: 0)
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCde2345677894')
    Order.create!(collect_zip: 112563601, collect_street: 'Rua três1', collect_number: 1205, collect_nhood: 'Laranja1', collect_city: 'Coronga1', 
                  collect_state: 'MT1', width: 1101, height: 1121, depth: 113, weight: 1201, deliv_reipient: 'Um Dois Três de Oliveira Quatro2', deliv_zip: 112365480, 
                  deliv_street: 'Rua Condongas1', deliv_number: 11051, deliv_nhood: 'Rosario1', deliv_city: 'Joca1', deliv_state: 'R0', km_dist: 1321, 
                  user_id: user.id, status: 0)
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCD12345677894')
    Order.create!(collect_zip: 11256361, collect_street: 'Rua três', collect_number: 1205, collect_nhood: 'Laranja', collect_city: 'Coronga', 
                  collect_state: 'MT', width: 110, height: 112, depth: 113, weight: 120, deliv_reipient: 'Um Dois Três de Oliveira Quatro1', deliv_zip: 11365480, 
                  deliv_street: 'Rua Condongas', deliv_number: 1105 , deliv_nhood: 'Rosario', deliv_city: 'Joca', deliv_state: 'RR', km_dist: 1320, 
                  user_id: user.id, status: 1)



    visit root_path
    click_on ('Cotação')


    expect(page).to have_content 'Código identificador: ABCD12345678912'
    expect(page).to have_content 'CEP de coleta: 11256360'
    expect(page).to have_content 'Endereço de coleta: Rua um dois três, 205 - Laranjeiras Condongas - MS'
    expect(page).to have_content 'Dimensões do produto: 10cm X 12cm X 13cm'
    expect(page).to have_content 'Peso: 20kg'
    expect(page).to have_content 'Nome do destinatário: Um Dois Três de Oliveira Quatro'
    expect(page).to have_content 'CEP de entrega: 12365480'
    expect(page).to have_content 'Endereço de entrega: Rua Condongueira, 105 - Canelas Jocacia - MT'
    expect(page).to have_content 'Distância em KM: 320'
    expect(page).to have_content 'Situação: pendente'

    expect(page).not_to have_content 'Código identificador: ABCD12345677894'
    expect(page).not_to have_content 'CEP de coleta: 11256361'
    expect(page).not_to have_content 'Endereço de coleta: Rua três, 1205 - Laranja Coronga - MT'
    expect(page).not_to have_content 'Dimensões do produto: 110cm X 112cm X 113'
    expect(page).not_to have_content 'Peso: 120kg'
    expect(page).not_to have_content 'Nome do destinatário: Um Dois Três de Oliveira Quatro1'
    expect(page).not_to have_content 'CEP de entrega: 11365480'
    expect(page).not_to have_content 'Rua Condongas, 1105 - Rosario Joca - RR'
    expect(page).not_to have_content 'Distância em KM: 1320'
    expect(page).not_to have_content 'Situação: entregue'
    expect(page).not_to have_content 'Situação: cancelada'
  end
  it 'com valores de operação frete e prazo' do
    user = User.create!(name: 'Bruno', email:'bruno@email.com', password:'password')
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCD12345678912')
    Order.create!(collect_zip: 11256360, collect_street: 'Rua um dois três', collect_number: 205, collect_nhood: 'Laranjeiras', collect_city: 'Condongas', 
                  collect_state: 'MS', width: 10, height: 12, depth: 13, weight: 82, deliv_reipient: 'Um Dois Três de Oliveira Quatro', deliv_zip: 12365480, 
                  deliv_street: 'Rua Condongueira', deliv_number: 105 , deliv_nhood: 'Canelas', deliv_city: 'Jocacia', deliv_state: 'MT', km_dist: 102, 
                  user_id: user.id, status: 0)
    shipping1 = Shipping.create!(name: 'GP003', min_dist: 10, max_dist: 110, min_weight: 60, max_weight: 120, deliv_fee: 250)
    shipping = Shipping.create!(name: 'GP004', min_dist: 111, max_dist: 180, min_weight: 26, max_weight: 76, deliv_fee: 250)
    Cost.create!(int_min_weight: 60, int_max_weight: 80, km_value: 15, shipping: shipping1)
    Cost.create!(int_min_weight: 81, int_max_weight: 100, km_value: 45, shipping: shipping1)
    Cost.create!(int_min_weight: 101, int_max_weight: 120, km_value: 75, shipping: shipping1)
    DelivTerm.create!(term_int_min_weight: 60, term_int_max_weight: 80, deliv_term: 15, shipping: shipping1)
    DelivTerm.create!(term_int_min_weight: 81, term_int_max_weight: 100, deliv_term: 45, shipping: shipping1)
    DelivTerm.create!(term_int_min_weight: 101, term_int_max_weight: 120, deliv_term: 75, shipping: shipping1)

    visit root_path
    click_on 'Cotação'
    click_on 'ABCD12345678912'

    expect(page).to have_content 'Código identificador: ABCD12345678912'
    expect(page).to have_content 'CEP de coleta: 11256360'
    expect(page).to have_content 'Endereço de coleta: Rua um dois três, 205 - Laranjeiras Condongas - MS'
    expect(page).to have_content 'Dimensões do produto: 10cm X 12cm X 13'
    expect(page).to have_content 'Peso: 82kg'
    expect(page).to have_content 'Nome do destinatário: Um Dois Três de Oliveira Quatro'
    expect(page).to have_content 'CEP de entrega: 12365480'
    expect(page).to have_content 'Endereço de entrega: Rua Condongueira, 105 - Canelas Jocacia - MT'
    expect(page).to have_content 'Distância em KM: 102km'
    expect(page).to have_content 'Situação: pendente'
    expect(page).to have_content 'Modalidade de transporte: GP003'
    expect(page).to have_content 'Pedido criado por: Bruno'
    expect(page).to have_content 'Valor do km rodado: R$ 0,45'
    expect(page).to have_content 'Valor de taxa de entrega: R$ 250,00'
    expect(page).to have_content 'Valor total da operação: R$ 295,00'
  end
end