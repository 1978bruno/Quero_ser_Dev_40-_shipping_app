require 'rails_helper'

describe 'Usuário edit relação prazo X distância' do
  it 'com sucesso' do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password')
    shipping_id = Shipping.create!(name: 'Rio', min_dist: 60, max_dist: 120, min_weight: 200, max_weight: 800,
                                   deliv_fee: 250, status: 1)
    DelivTerm.create!(term_int_min_weight: 125, term_int_max_weight: 150, deliv_term: 15, shipping: shipping_id)

    visit root_path
    login_as(user)
    click_on 'Rio'
    find('td#deliv_term_1').click_on('editar')
    fill_in 'Peso mínimo', with: 115
    fill_in 'Peso máximo', with: 130
    fill_in 'Prazo de entrega', with: 25
    click_on 'Cadastrar'

    expect(page).to have_content 'Cadastro realizado com sucesso'
    expect(page).to have_content '115kg'
    expect(page).to have_content '130kg'
    expect(page).to have_content '25 dias'
  end
  it 'sem sucesso' do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password')
    shipping_id = Shipping.create!(name: 'Rio', min_dist: 60, max_dist: 120, min_weight: 200, max_weight: 800,
                                   deliv_fee: 250, status: 1)
    DelivTerm.create!(term_int_min_weight: 125, term_int_max_weight: 150, deliv_term: 15, shipping: shipping_id)

    visit root_path
    login_as(user)
    click_on 'Rio'
    find('td#deliv_term_1').click_on('editar')
    fill_in 'Peso mínimo', with: ''
    fill_in 'Peso máximo', with: 150
    fill_in 'Prazo de entrega', with: 15
    click_on 'Cadastrar'

    expect(page).to have_content 'Cadastro não realizado'
    expect(page).to have_content 'Não podem existir campos em branco'
  end
end
