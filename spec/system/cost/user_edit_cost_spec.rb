require 'rails_helper'

describe 'Usuário edita relação preço X peso' do
  it 'com sucesso' do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password')
    shipping_id = Shipping.create!(name: 'Rio', min_dist: 60, max_dist: 120, min_weight: 200, max_weight: 800,
                                   deliv_fee: 250)
    Cost.create!(int_min_weight: 125, int_max_weight: 150, km_value: 15, shipping: shipping_id)

    visit root_path
    login_as(user)
    click_on 'Rio'
    find('td#cost_1').click_on('editar')
    fill_in 'Peso mínimo', with: 100
    fill_in 'Peso máximo', with: 110
    fill_in 'Valor por KM', with: 0.30
    click_on 'Cadastrar'

    expect(page).to have_content 'Cadastro realizado com sucesso'
    expect(page).to have_content '100kg'
    expect(page).to have_content '110kg'
    expect(page).to have_content 'R$ 0,30'
  end
  it 'sem sucesso' do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password')
    shipping_id = Shipping.create!(name: 'Rio', min_dist: 60, max_dist: 120, min_weight: 200, max_weight: 800,
                                   deliv_fee: 250)
    Cost.create!(int_min_weight: 125, int_max_weight: 150, km_value: 15, shipping: shipping_id)

    visit root_path
    login_as(user)
    click_on 'Rio'
    find('td#cost_1').click_on('editar')
    fill_in 'Peso mínimo', with: ''
    fill_in 'Peso máximo', with: 150
    fill_in 'Valor por KM', with: 15
    click_on 'Cadastrar'

    expect(page).to have_content 'Cadastro não realizado'
    expect(page).to have_content 'Não podem existir campos em branco'
  end
end
