require 'rails_helper'

describe 'Usuário edita um veículo' do
  context 'estando na tela de listagem de veículos' do
    it 'com sucesso' do
      vehicle_cat1 = VehicleCategory.create!(category: 'PickUp')
      vehicle_typ1 = VehicleType.create!(manufacturer_vehicle: 'VW', model_vehicle: 'Amarok')
      vehicle_cat2 = VehicleCategory.create!(category: 'Sedan médio')
      vehicle_typ2 = VehicleType.create!(manufacturer_vehicle: 'GM', model_vehicle: 'Prisma')
      vehicle1 = Vehicle.create!(license_plate: '0EM-7777', manufature_year: '2020', maximum_load_capacity: '1000',
                                 vehicle_types_id: vehicle_typ1.id, vehicle_categories_id: vehicle_cat1.id)
      vehicle1 = Vehicle.create!(license_plate: '0EM-9999', manufature_year: '2022', maximum_load_capacity: '400',
                                 vehicle_types_id: vehicle_typ2.id, vehicle_categories_id: vehicle_cat2.id)
      visit root_path
      click_on 'Veículos'
      click_on 'lista de veículo'
      click_on '0EM-7777'
      fill_in 'Placa do Veículo', with: 'HHV-0880'
      fill_in 'Ano de Fabricação', with: 2020
      fill_in 'Capacidade máxima de carga', with: 500
      page.check('Situação')
      click_on 'Gravar'

      expect(page).to have_content 'Dados do veículo atualizados com sucesso'
      expect(page).to have_content 'Categoria: PickUp'
      expect(page).to have_content 'Marca: VW'
      expect(page).to have_content 'Modelo: Amarok'
      expect(page).to have_content 'HHV-0880'
      expect(page).to have_content 'Ano de Fabricação: 2020'
      expect(page).to have_content 'Capacidade máxima de carga: 500kg'
      expect(page).to have_content 'Situação: inativo'
    end
    it 'sem sucesso' do
      vehicle_cat1 = VehicleCategory.create!(category: 'PickUp')
      vehicle_typ1 = VehicleType.create!(manufacturer_vehicle: 'VW', model_vehicle: 'Amarok')
      vehicle_cat2 = VehicleCategory.create!(category: 'Sedan médio')
      vehicle_typ2 = VehicleType.create!(manufacturer_vehicle: 'GM', model_vehicle: 'Prisma')
      vehicle1 = Vehicle.create!(license_plate: '0EM-7777', manufature_year: '2020', maximum_load_capacity: '1000',
                                 vehicle_types_id: vehicle_typ1.id, vehicle_categories_id: vehicle_cat1.id)
      vehicle1 = Vehicle.create!(license_plate: '0EM-9999', manufature_year: '2022', maximum_load_capacity: '400',
                                 vehicle_types_id: vehicle_typ2.id, vehicle_categories_id: vehicle_cat2.id)
      visit root_path
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
