require 'rails_helper'

describe 'Usuário vê status da frota' do
  it 'a partir do menu' do

    
   visit root_path
   within('nav') do
     click_on 'Veículos'
   end

   expect(current_path).to eq vehicles_path
 end
  it 'com sucesso' do
    vehicle_category = VehicleCategory.create!(category: 'Sedan médio')
    vehicle_type = VehicleType.create!(manufacturer_vehicle: 'GM', model_vehicle: 'Prisma')
    Vehicle.create!(license_plate: 'HHV-0880', manufature_year: '2020', maximum_load_capacity: 500, 
                    vehicle_type: vehicle_types_id, vehicle_category: vehicle_categories_id)
  
    visit root_path
    click_on 'Veículos'

    expect(page).to have_content 'Sedan médio'
    expect(page).to have_content 'GM'
    expect(page).to have_content 'Prisma'
    expect(page).to have_content 'HHV-0880'
    expect(page).to have_content '2020'
    expect(page).to have_content '500'
  end
# it 'e não existem produtos cadastrados' do
#  user = User.create!(email:'bruno@email.com', password:'password')
# 
#    login_as(user)
#    visit root_path
#    within('nav') do
#      click_on 'Modelos de Produtos'
#    end
#    click_on 'Modelos de Produtos'

#    expect(page).to have_content 'Nenhum modelo de produto cadastrado'
#  end

end