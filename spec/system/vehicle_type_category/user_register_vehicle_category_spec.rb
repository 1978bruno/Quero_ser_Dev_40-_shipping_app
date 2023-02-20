require 'rails_helper'

describe 'Usuário cadastra um novo modelo de veículo' do
  it 'com sucesso' do
    visit root_path
    click_on 'Veículos'
    click_on 'Cadastrar categoria de veículo'
    fill_in  'Categoria', with: 'Sedan médio'
    click_on 'Gravar'
    expect(page).to have_content 'A categoria de veículo Sedan médio foi cadastrado com sucesso'
  end
  it 'sem sucesso' do
    visit root_path
    click_on 'Veículos'
    click_on 'Cadastrar categoria de veículo'
    click_on 'Gravar'

    expect(page).to have_content 'Categoria do veículo não cadastrado'
    expect(page).to have_content 'Categoria não pode ficar em branco'
  end
end
