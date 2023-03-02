require 'rails_helper'

describe 'Usuário cadastra um veículo' do
  it 'com sucesso' do
    user = User.create!(name: 'User', email: 'user@email.com', password: 'pwd123456')
    VehicleCategory.create!(category: 'PickUp')
    VehicleType.create!(manufacturer_vehicle: 'VW', model_vehicle: 'Amarok')
    VehicleCategory.create!(category: 'Sedan médio')
    VehicleType.create!(manufacturer_vehicle: 'GM', model_vehicle: 'Prisma')

    visit root_path
    login_as(user)
    click_on 'Cadastrar Veículo'
    select 'Sedan médio', from: 'Categoria'
    select 'Prisma', from: 'Modelo'
    fill_in 'Placa do Veículo', with: 'HHV-0880'
    fill_in 'Ano de Fabricação', with: 2020
    fill_in 'Capacidade máxima de carga', with: 500
    page.check('Situação')
    click_on 'Gravar'

    expect(page).to have_content 'Veículo cadastrado com sucesso'
    expect(page).to have_content 'HHV-0880 GM Prisma 2020 500 kg Sedan médio inativo'
    expect(page).not_to have_content ' ativo'
  end
  it 'sem sucesso' do
    user = User.create!(name: 'User', email: 'user@email.com', password: 'pwd123456')
    VehicleCategory.create!(category: 'PickUp')
    VehicleType.create!(manufacturer_vehicle: 'VW', model_vehicle: 'Amarok')
    VehicleCategory.create!(category: 'Sedan médio')
    VehicleType.create!(manufacturer_vehicle: 'GM', model_vehicle: 'Prisma')

    visit root_path
    login_as(user)
    click_on 'Cadastrar Veículo'
    select 'Sedan médio', from: 'Categoria'
    select 'Prisma', from: 'Modelo'
    fill_in 'Placa do Veículo', with: ''
    fill_in 'Ano de Fabricação', with: ''
    fill_in 'Capacidade máxima de carga', with: ''
    click_on 'Gravar'

    expect(page).to have_content 'Veículo não cadastrado'
    expect(page).to have_content 'Placa do Veículo não pode ficar em branco'
    expect(page).to have_content 'Ano de Fabricação não pode ficar em branco'
    expect(page).to have_content 'Capacidade máxima de carga não pode ficar em branco'
  end
end
