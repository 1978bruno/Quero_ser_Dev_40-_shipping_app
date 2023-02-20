require 'rails_helper'

describe 'Usuário navega até os detalhes da modalidade de transporte' do
  it 'e edita o cadastro' do
    shipping0 = Shipping.create!(name: 'Rio', min_dist: 60, max_dist: 120, min_weight: 200, max_weight: 800,
                                 deliv_fee: 250)
    Cost.create!(int_min_weight: 125, int_max_weight: 150, km_value: 15, shipping: shipping0)
    DelivTerm.create!(term_int_min_weight: 125, term_int_max_weight: 150, deliv_term: 15, shipping: shipping0)

    visit root_path
    click_on 'Rio'
    click_on 'Cotação'
    click_on 'Editar ordem'
    fill_in 'Nome', with: 'OP001'

    expect(page).to have_content('Nome da Modalidade: OP001')
    expect(page).to have_content('Distância mínima: 60km')
    expect(page).to have_content('Distância máxima: 120km')
    expect(page).to have_content('Peso mínimo da carga: 200kg')
    expect(page).to have_content('Peso máximo da carga: 800kg')
    expect(page).to have_content('Tarifa padrão: R$ 250')
  end
end
