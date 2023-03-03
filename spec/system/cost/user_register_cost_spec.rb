require 'rails_helper'

describe 'Usuário parametriza relação preço X peso' do
  it 'e deve estar autenticado' do
    visit root_path
    click_on 'Cadastrar Custo'
    expect(current_path).to eq new_user_session_path
  end
  it 'iniciando pela tela inicial' do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password')
    visit root_path
    login_as(user)
    click_on 'Cadastrar Custo'
    expect(page).to have_field 'Peso mínimo'
    expect(page).to have_field 'Peso máximo'
    expect(page).to have_field 'Valor por KM'
  end
  it 'com sucesso' do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password')
    shipping_id = Shipping.create!(name: 'Rio', min_dist: 60, max_dist: 120, min_weight: 200, max_weight: 800,
                                   deliv_fee: 250, status: 1)
    DelivTerm.create!(term_int_min_weight: 125, term_int_max_weight: 150, deliv_term: 15, shipping: shipping_id)

    visit root_path
    login_as(user)
    click_on('Cadastrar Custo')
    select 'Rio', from: 'Modelo'
    fill_in 'Peso mínimo', with: 125
    fill_in 'Peso máximo', with: 150
    fill_in 'Valor por KM', with: 15
    click_on 'Cadastrar'

    expect(page).to have_content 'Cadastro realizado com sucesso'
    expect(page).to have_content '125kg'
    expect(page).to have_content '150kg'
    expect(page).to have_content 'R$ 15'
  end
  it 'sem sucesso' do
    user = User.create!(name: 'Bruno', email: 'bruno@email.com', password: 'password')
    Shipping.create!(name: 'Rio', min_dist: 60, max_dist: 120, min_weight: 200, max_weight: 800,
                     deliv_fee: 250, status: 1)

    visit root_path
    login_as(user)
    click_on('Cadastrar Custo')
    select 'Rio', from: 'Modelo'
    fill_in 'Peso mínimo', with: ''
    fill_in 'Peso máximo', with: 150
    fill_in 'Valor por KM', with: 15
    click_on 'Cadastrar'

    expect(page).to have_content 'Cadastro não realizado'
    expect(page).to have_content 'Não podem existir campos em branco'
  end
end
