require 'rails_helper'

describe 'Usuário atualiza status da modalidade de transporte' do
  it 'ativando' do
    shipping0 = Shipping.create!(name: 'Rio', min_dist: 60, max_dist: 120, min_weight: 200, max_weight: 800,
                                 deliv_fee: 250)
    Cost.create!(int_min_weight: 125, int_max_weight: 150, km_value: 15, shipping: shipping0)
    DelivTerm.create!(term_int_min_weight: 125, term_int_max_weight: 150, deliv_term: 15, shipping: shipping0)

    visit root_path
    find('div#Rio').click_on('Ativar')

    expect(page).to have_content 'ativo'
    expect(page).not_to have_content 'inativo'
  end
  it 'desativando' do
    shipping0 = Shipping.create!(name: 'Rio', min_dist: 60, max_dist: 120, min_weight: 200, max_weight: 800,
                                 deliv_fee: 250, status: 1)
    Cost.create!(int_min_weight: 125, int_max_weight: 150, km_value: 15, shipping: shipping0)
    DelivTerm.create!(term_int_min_weight: 125, term_int_max_weight: 150, deliv_term: 15, shipping: shipping0)

    visit root_path
    find('div#Rio').click_on('Desativar')

    expect(page).not_to have_content ' ativo'
    expect(page).to have_content 'inativo'
  end
end
