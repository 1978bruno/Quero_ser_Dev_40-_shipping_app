require 'rails_helper'

describe 'Usuário atualiza status do veículo' do
  it 'ativando' do
    user = User.create!(name: 'User', email: 'user@email.com', password: 'pwd123456')
    vehicle_category_id = VehicleCategory.create!(category: 'Sedan médio')
    vehicle_type_id = VehicleType.create!(manufacturer_vehicle: 'GM', model_vehicle: 'Prisma')
    Vehicle.create!(license_plate: 'HHV-0880', manufature_year: '2020', maximum_load_capacity: 500,
                    vehicle_type: vehicle_type_id, vehicle_category: vehicle_category_id)

    visit root_path
    login_as(user)
    click_on 'Veículos'
    click_on 'lista de veículo'
    find('td#HHV-0880').click_on 'Ativar'

    expect(page).to have_content 'ativo'
    expect(page).not_to have_content 'inativo'
  end
  it 'desativando' do
    user = User.create!(name: 'User', email: 'user@email.com', password: 'pwd123456')
    vehicle_category_id = VehicleCategory.create!(category: 'Sedan médio')
    vehicle_type_id = VehicleType.create!(manufacturer_vehicle: 'GM', model_vehicle: 'Prisma')
    Vehicle.create!(license_plate: 'HHV-0880', manufature_year: '2020', maximum_load_capacity: 500,
                    vehicle_type: vehicle_type_id, vehicle_category: vehicle_category_id, status: 1)

    visit root_path
    login_as(user)
    click_on 'Veículos'
    click_on 'lista de veículo'
    find('td#HHV-0880').click_on 'Desativar'

    expect(page).not_to have_content ' ativo'
    expect(page).to have_content 'inativo'
  end
end
