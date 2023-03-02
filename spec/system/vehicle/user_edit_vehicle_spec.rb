require 'rails_helper'

describe 'Usuário edita um veículo' do
  context 'estando na tela de listagem de veículos' do
    it 'com sucesso' do
      user = User.create!(name: 'User', email: 'user@email.com', password: 'pwd123456')
      vehicle_cat1 = VehicleCategory.create!(category: 'PickUp')
      vehicle_typ1 = VehicleType.create!(manufacturer_vehicle: 'VW', model_vehicle: 'Amarok')
      vehicle_cat2 = VehicleCategory.create!(category: 'Sedan médio')
      vehicle_typ2 = VehicleType.create!(manufacturer_vehicle: 'GM', model_vehicle: 'Prisma')
      Vehicle.create!(license_plate: '0EM-7777', manufature_year: '2020', maximum_load_capacity: '1000',
                      vehicle_type: vehicle_typ1, vehicle_category: vehicle_cat1)
      Vehicle.create!(license_plate: '0EM-9999', manufature_year: '2022', maximum_load_capacity: '400',
                      vehicle_type: vehicle_typ2, vehicle_category: vehicle_cat2)
      visit root_path
      login_as(user)
      click_on 'Veículos'
      click_on 'lista de veículo'
      click_on '0EM-7777'
      fill_in 'Placa do Veículo', with: 'HHV-0880'
      fill_in 'Ano de Fabricação', with: 2020
      fill_in 'Capacidade máxima de carga', with: 500
      page.check('Situação')
      click_on 'Gravar'

      expect(page).to have_content 'Dados do veículo atualizados com sucesso'
      expect(page).to have_content 'HHV-0880 VW Amarok 2020 500 kg PickUp inativo'
      expect(page).to have_content '0EM-9999 GM Prisma 2022 400 kg Sedan médio inativo'
    end
    it 'sem sucesso' do
      user = User.create!(name: 'User', email: 'user@email.com', password: 'pwd123456')
      vehicle_cat1 = VehicleCategory.create!(category: 'PickUp')
      vehicle_typ1 = VehicleType.create!(manufacturer_vehicle: 'VW', model_vehicle: 'Amarok')
      vehicle_cat2 = VehicleCategory.create!(category: 'Sedan médio')
      vehicle_typ2 = VehicleType.create!(manufacturer_vehicle: 'GM', model_vehicle: 'Prisma')
      Vehicle.create!(license_plate: '0EM-7777', manufature_year: '2020', maximum_load_capacity: '1000',
                      vehicle_type: vehicle_typ1, vehicle_category: vehicle_cat1)
      Vehicle.create!(license_plate: '0EM-9999', manufature_year: '2022', maximum_load_capacity: '400',
                      vehicle_type: vehicle_typ2, vehicle_category: vehicle_cat2)
      visit root_path
      login_as(user)
      click_on 'Veículos'
      click_on 'lista de veículo'
      click_on '0EM-7777'
      fill_in 'Placa do Veículo', with: 'HHV-0880'
      fill_in 'Ano de Fabricação', with: ''
      fill_in 'Capacidade máxima de carga', with: ''
      page.check('Situação')
      click_on 'Gravar'

      expect(page).to have_content 'Não foi possível atualizar os dados do veículo.'
    end
  end
end
