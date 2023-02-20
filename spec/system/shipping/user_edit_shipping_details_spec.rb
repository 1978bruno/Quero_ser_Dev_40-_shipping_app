require 'rails_helper'

describe 'Usuário visualiza detalhes de uma modalidade de transporte' do
  it 'e edita o cadastro' do
    shipping0 = Shipping.create!(name: 'Rio', min_dist: 60, max_dist: 120, min_weight: 200, max_weight: 800,
                                 deliv_fee: 250)
    Cost.create!(int_min_weight: 125, int_max_weight: 150, km_value: 15, shipping: shipping0)
    DelivTerm.create!(term_int_min_weight: 125, term_int_max_weight: 150, deliv_term: 15, shipping: shipping0)

    visit root_path
    click_on 'Rio'
    click_on 'Editar Modalidade'
    fill_in 'Nome', with: 'OP001'
    click_on 'Enviar'

    expect(page).to have_content('Nome da Modalidade: OP001')
  end
end
