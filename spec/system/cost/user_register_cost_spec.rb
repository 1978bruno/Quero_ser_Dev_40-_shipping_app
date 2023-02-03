require 'rails_helper'

describe 'Usuário parametriza relação preço X peso' do
  it 'e deve estar autenticado' do
    

    visit root_path
    click_on 'Cadastrar Custo'

    expect(current_path).to eq new_user_session_path
  end
  it 'iniciando pela tela inicial' do
    User.create!(name: 'Bruno', email:'bruno@email.com', password:'password')

    visit root_path
    click_on ('Cadastrar Custo')
    within('form') do
      fill_in 'E-mail', with: 'bruno@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    expect(page).to have_field('Peso mínimo')
    expect(page).to have_field('Peso máximo')
    expect(page).to have_field('Valor por KM')

  end
end