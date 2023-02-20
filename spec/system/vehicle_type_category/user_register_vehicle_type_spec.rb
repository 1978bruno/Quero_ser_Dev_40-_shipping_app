require 'rails_helper'

describe 'Usuário cadastra um novo modelo de veículo' do
  it 'com sucesso' do
    visit root_path
    click_on 'Veículos'
    click_on 'Cadastrar modelo de veículo'
    fill_in 'Modelo', with: 'Prisma'
    fill_in 'Fabricante', with: 'GM'
    click_on 'Gravar'

    expect(page).to have_content 'O veículo modelo: Prisma - GM foi cadastrado com sucesso'
  end
  it 'sem sucesso' do
    visit root_path
    click_on 'Veículos'
    click_on 'Cadastrar modelo de veículo'
    click_on 'Gravar'

    expect(page).to have_content 'Modelo do veículo não cadastrado'
    expect(page).to have_content 'Modelo não pode ficar em branco'
    expect(page).to have_content 'Fabricante não pode ficar em branco'
  end
end
