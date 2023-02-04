require 'rails_helper'

describe 'Usuário visualiza tabela de valores no detalhes de uma modalidade de transporte' do
  it 'e vê as informações' do
    shipping = Shipping.create!(name: 'Rio', min_dist: 60, max_dist: 120, min_weight: 200, max_weight: 800, 
                     deliv_fee: 250)
    Cost.create!(int_min_weight: 125, int_max_weight: 150, km_value: 15, shipping: shipping)
    DelivTerm.create!(term_int_min_weight: 125, term_int_max_weight: 150, deliv_term: 15, shipping: shipping)
   
    visit(root_path)
    click_on('Rio')

    expect(page).to have_content('Menor peso do intervalo: 125kg')
    expect(page).to have_content('Maior peso do intervalo: 150kg')
    expect(page).to have_content('Valor do KM: R$ 15')

  end
  it 'e volta para a tela inicial' do
    shipping = Shipping.create!(name: 'Rio', min_dist: 60, max_dist: 120, min_weight: 200, max_weight: 800, 
      deliv_fee: 250)
    Cost.create!(int_min_weight: 125, int_max_weight: 150, km_value: 15, shipping: shipping)
    DelivTerm.create!(term_int_min_weight: 125, term_int_max_weight: 150, deliv_term: 15, shipping: shipping)

    visit(root_path)
    click_on 'Rio'
    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end

end