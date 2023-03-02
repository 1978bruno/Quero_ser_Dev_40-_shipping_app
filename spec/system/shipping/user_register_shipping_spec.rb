require 'rails_helper'

describe 'Usuário cadastra nova modalidade de transporte' do
  it 'iniciando pela tela inicial' do
    user = User.create!(name: 'User', email: 'user@email.com', password: 'pwd123456')
    visit root_path
    login_as(user)
    click_on 'Cadastrar modalidade'

    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Distância mínima'
    expect(page).to have_field 'Distância máxima'
    expect(page).to have_field 'Peso mínimo'
    expect(page).to have_field 'Peso máximo'
    expect(page).to have_field 'Tarifa de entrega'
  end
  it 'com sucesso' do
    user = User.create!(name: 'User', email: 'user@email.com', password: 'pwd123456')

    visit root_path
    login_as(user)
    click_on 'Cadastrar modalidade'
    fill_in 'Nome',             with: 'MOC'
    fill_in 'Distância mínima', with: '100'
    fill_in 'Distância máxima', with: '800'
    fill_in 'Peso mínimo',      with: '300'
    fill_in 'Peso máximo',      with: '1500'
    fill_in 'Tarifa de entrega', with: '2500'
    click_on 'Enviar'

    expect(current_path).to eq root_path
    expect(page).to have_content 'MOC'
    expect(page).to have_content '100'
    expect(page).to have_content '800'
  end
  it 'e habilitar o botao de status' do
    user = User.create!(name: 'User', email: 'user@email.com', password: 'pwd123456')
    visit root_path
    login_as(user)
    click_on 'Cadastrar modalidade'
    fill_in 'Nome',             with: 'MOC'
    fill_in 'Distância mínima', with: '100'
    fill_in 'Distância máxima', with: '800'
    fill_in 'Peso mínimo',      with: '300'
    fill_in 'Peso máximo',      with: '1500'
    fill_in 'Tarifa de entrega', with: '2500'
    page.check('Situação')
    click_on 'Enviar'
  end
end
