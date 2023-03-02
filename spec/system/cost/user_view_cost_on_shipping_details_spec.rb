require 'rails_helper'

describe 'Usuário visualiza tabela de valores no detalhes de uma modalidade de transporte' do
  it 'e vê as informações' do
    shipping0 = Shipping.create!(
      name: 'Rio', min_dist: 60, max_dist: 120, min_weight: 200, max_weight: 800,
      deliv_fee: 250
    )
    Cost.create!(int_min_weight: 125, int_max_weight: 150, km_value: 15, shipping: shipping0)
    DelivTerm.create!(term_int_min_weight: 125, term_int_max_weight: 150, deliv_term: 15, shipping: shipping0)
    visit root_path
    click_on 'Rio'
    expect(page).to have_content '125kg'
    expect(page).to have_content '150kg'
    expect(page).to have_content 'R$ 15'
  end
  it 'e volta para a tela inicial' do
    shipping0 = Shipping.create!(
      name: 'Rio', min_dist: 60, max_dist: 120, min_weight: 200, max_weight: 800,
      deliv_fee: 250
    )
    Cost.create!(int_min_weight: 125, int_max_weight: 150, km_value: 15, shipping: shipping0)
    DelivTerm.create!(term_int_min_weight: 125, term_int_max_weight: 150, deliv_term: 15, shipping: shipping0)

    visit root_path
    click_on 'Rio'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end
