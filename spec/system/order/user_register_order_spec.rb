require 'rails_helper'

describe 'Usuário cria ordem de entrega' do
  it 'e deve estar autenticado' do
    

    visit root_path
    click_on 'Criar ordem'

    expect(current_path).to eq new_user_session_path
  end
  it 'iniciando pela tela inicial' do
    User.create!(name: 'Bruno', email:'bruno@email.com', password:'password')

    visit root_path
    click_on 'Criar ordem'
    within('form') do
      fill_in 'E-mail', with: 'bruno@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    expect(page).to have_field('Endereço de coleta')
    expect(page).to have_field('Largura')
    expect(page).to have_field('Altura')
    expect(page).to have_field('Profundidade')
    expect(page).to have_field('Peso')
    expect(page).to have_field('Nome do destinatário')
    expect(page).to have_field('Endereço de entrega')
    expect(page).to have_field('Distância em KM')

  end
  it 'com sucesso' do
    User.create!(name: 'Bruno', email:'bruno@email.com', password:'password')
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCD12345678912')

    visit root_path
    click_on 'Criar ordem'
    within('form') do
      fill_in 'E-mail', with: 'bruno@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    fill_in 'CEP de coleta', with: 32223380
    fill_in 'Endereço de coleta', with: 'Rua um dois três'
    fill_in 'Número de coleta', with: 205
    fill_in 'Bairro de coleta', with: 'Laranjeiras'
    fill_in 'Cidade de coleta', with: 'Condongas'
    fill_in 'Estado de coleta', with: 'MS'
    fill_in 'Largura', with: 10
    fill_in 'Altura', with: 12
    fill_in 'Profundidade', with: 13
    fill_in 'Peso', with: 20
    fill_in 'Nome do destinatário', with: 'Um Dois Três de Oliveira Quatro'
    fill_in 'CEP de entrega', with: 39400215
    fill_in 'Endereço de entrega', with: 'Rua Condongueira'
    fill_in 'Número de entrega', with: 105
    fill_in 'Bairro de entrega', with: 'Canelas'
    fill_in 'Cidade de entrega', with: 'Jocacia'
    fill_in 'Estado de entrega', with: 'MT'
    fill_in 'Distância em KM', with: 360
    click_on 'Cadastrar'

    expect(page).to have_content 'Pedido registrado com sucesso'
    expect(page).to have_content 'Código identificador: ABCD12345678912'
    expect(page).to have_content 'Nome do destinatário: Um Dois Três de Oliveira Quatro'
    expect(page).to have_content 'Dimensões do produto: 10cm X 12cm X 13cm'
    expect(page).to have_content 'Distância em KM: 360km'
  end
  it 'sem sucesso' do
    User.create!(name: 'Bruno', email:'bruno@email.com', password:'password')

    visit root_path
    click_on 'Criar ordem'
    within('form') do
      fill_in 'E-mail', with: 'bruno@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    fill_in 'CEP de coleta', with: 32223380
    fill_in 'Endereço de coleta', with: 'Rua um dois três'
    fill_in 'Número de coleta', with: ''
    fill_in 'Bairro de coleta', with: 'Laranjeiras'
    fill_in 'Cidade de coleta', with: 'Condongas'
    fill_in 'Estado de coleta', with: 'MS'
    fill_in 'Largura', with: 10
    fill_in 'Altura', with: 12
    fill_in 'Profundidade', with: 13
    fill_in 'Peso', with: 20
    fill_in 'Nome do destinatário', with: 'Um Dois Três de Oliveira Quatro'
    fill_in 'CEP de entrega', with: 39400215
    fill_in 'Endereço de entrega', with: 'Rua Condongueira'
    fill_in 'Número de entrega', with: 105
    fill_in 'Bairro de entrega', with: 'Canelas'
    fill_in 'Cidade de entrega', with: 'Jocacia'
    fill_in 'Estado de entrega', with: 'MT'
    fill_in 'Distância em KM', with: 360
    click_on 'Cadastrar'

    expect(page).to have_content 'Não foi possível registrar o pedido'
    expect(page).to have_content 'Número de coleta não pode ficar em branco'

  end
  it 'com sucesso' do
    User.create!(name: 'Bruno', email:'bruno@email.com', password:'password')
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCD12345678912')

    visit root_path
    click_on 'Criar ordem'
    within('form') do
      fill_in 'E-mail', with: 'bruno@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    fill_in 'CEP de coleta', with: 32223380
    click_on 'Endereço de coleta'
    fill_in 'Número de coleta', with: 205
    fill_in 'Largura', with: 10
    fill_in 'Altura', with: 12
    fill_in 'Profundidade', with: 13
    fill_in 'Peso', with: 20
    fill_in 'Nome do destinatário', with: 'Um Dois Três de Oliveira Quatro'
    fill_in 'CEP de entrega', with: 39400215
    click_on 'Endereço de entrega'
    fill_in 'Número de entrega', with: 21
    fill_in 'Distância em KM', with: 360
    click_on 'Cadastrar'

    expect(page).to have_content 'Pedido registrado com sucesso'
    expect(page).to have_content 'Código identificador: ABCD12345678912'
    expect(page).to have_content 'Endereço de coleta: Rua Oliveira'
    expect(page).to have_content 'Nome do destinatário: Um Dois Três de Oliveira Quatro'
    expect(page).to have_content 'Endereço de entrega: Avenida Deputado Esteves Rodrigues'
    expect(page).to have_content 'Dimensões do produto: 10cm X 12cm X 13cm'
    expect(page).to have_content 'Distância em KM: 360km'
  end
end