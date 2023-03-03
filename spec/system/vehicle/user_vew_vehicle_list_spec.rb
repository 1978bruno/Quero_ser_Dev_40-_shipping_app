require 'rails_helper'

describe 'Usuário acessa painel da frota' do
  it 'a partir do menu' do
    user = User.create!(name: 'User', email: 'user1@email.com', password: 'password')
    visit root_path
    login_as(user)
    within('nav') do
      click_on 'Veículos'
    end

    expect(current_path).to eq vehicles_path
  end
  it 'com sucesso' do
    user = User.create!(name: 'User', email: 'user1@email.com', password: 'password')
    vehicle_category_id = VehicleCategory.create!(category: 'Sedan médio')
    vehicle_type_id = VehicleType.create!(manufacturer_vehicle: 'GM', model_vehicle: 'Prisma')
    Vehicle.create!(license_plate: 'HHV-0880', manufature_year: '2020', maximum_load_capacity: 500,
                    vehicle_type: vehicle_type_id, vehicle_category: vehicle_category_id)

    visit root_path
    login_as(user)
    within('nav') do
      click_on 'Veículos'
    end

    expect(page).to have_content 'Sedan médio'
    expect(page).to have_content 'GM'
    expect(page).to have_content 'Prisma'
    expect(page).to have_content 'HHV-0880'
    expect(page).to have_content '2020'
    expect(page).to have_content '500'
  end
  it 'e não existem veículos cadastrados' do
    user = User.create!(name: 'User', email: 'user1@email.com', password: 'password')
    visit root_path
    login_as(user)
    within('nav') do
      click_on 'Veículos'
    end

    expect(page).to have_content 'Nenhum veículo cadastrado'
  end
  it 'sem estar logado e vê tela de login' do
    visit root_path
    within('nav') do
      click_on 'Veículos'
    end
    click_on 'lista de veículos'

    expect(page).to have_content 'Para continuar, efetue login ou registre-se.'
    expect(current_path).to eq user_session_path
  end
end
