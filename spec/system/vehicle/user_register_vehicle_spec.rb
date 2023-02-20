require 'rails_helper'

describe 'Usuário cadastra um veículo' do
  it 'com sucesso' do
    VehicleCategory.create!(category: 'PickUp')
    VehicleType.create!(manufacturer_vehicle: 'VW', model_vehicle: 'Amarok')
    VehicleCategory.create!(category: 'Sedan médio')
    VehicleType.create!(manufacturer_vehicle: 'GM', model_vehicle: 'Prisma')

    visit root_path
    click_on 'Cadastrar Veículo'
    select 'Sedan médio', from: 'Categoria'
    select 'Prisma', from: 'Modelo'
    fill_in 'Placa do Veículo', with: 'HHV-0880'
    fill_in 'Ano de Fabricação', with: 2020
    fill_in 'Capacidade máxima de carga', with: 500
    page.check('Situação')
    click_on 'Gravar'

    expect(page).to have_content 'Veículo cadastrado com sucesso'
    expect(page).to have_content 'Categoria: Sedan médio'
    expect(page).to have_content 'Marca: GM'
    expect(page).to have_content 'Modelo: Prisma'
    expect(page).to have_content 'HHV-0880'
    expect(page).to have_content 'Ano de Fabricação: 2020'
    expect(page).to have_content 'Capacidade máxima de carga: 500kg'
    expect(page).to have_content 'Situação: inativo'
  end
  it 'sem sucesso' do
    VehicleCategory.create!(category: 'PickUp')
    VehicleType.create!(manufacturer_vehicle: 'VW', model_vehicle: 'Amarok')
    VehicleCategory.create!(category: 'Sedan médio')
    VehicleType.create!(manufacturer_vehicle: 'GM', model_vehicle: 'Prisma')

    visit root_path
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
