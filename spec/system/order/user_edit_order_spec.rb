require 'rails_helper'

describe 'Usuário navega até os detalhes do pedido' do
  it 'e edita - com sucesso' do
    user = User.create!(name: 'User', email: 'user@email.com', password: 'pwd123456')
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCD12345678912')
    Order.create!(collect_zip: 11256360, collect_street: 'Rua um dois três', collect_number: 205, 
                collect_nhood: 'Laranjeiras', collect_city: 'Condongas', collect_state: 'MS', width: 10, height: 12, 
                depth: 13, weight: 82, deliv_reipient: 'Um Dois Três de Oliveira Quatro', deliv_zip: 12365480,
                deliv_street: 'Rua Condongueira', deliv_number: 105, deliv_nhood: 'Canelas', deliv_city: 'Jocacia', 
                deliv_state: 'MT', km_dist: 102, user: user, status: 0)

    visit root_path
    within('nav') do
      click_on 'Entrar'
    end
    within('form') do
      fill_in 'E-mail', with: user.email
      fill_in 'Senha', with: user.password
      click_on 'Entrar'     
    end
    click_on 'Cotação'
    click_on 'Orçamento'
    click_on 'ABCD12345678912'
    click_on 'Editar'
    fill_in 'Nome do destinatário', with: 'Usuário Completo 2'
    click_on 'Cadastrar'

    expect(page).to have_content 'Nome do destinatário: Usuário Completo 2'
    expect(page).not_to have_content 'Nome do destinatário: Um Dois Três de Oliveira Quatro'
  end
  it 'e deixa campo em branco - recebendo um erro' do
    user = User.create!(name: 'User', email: 'user@email.com', password: 'pwd123456')
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCD12345678912')
    Order.create!(collect_zip: 11256360, collect_street: 'Rua um dois três', collect_number: 205, 
                collect_nhood: 'Laranjeiras', collect_city: 'Condongas', collect_state: 'MS', width: 10, height: 12, 
                depth: 13, weight: 82, deliv_reipient: 'Um Dois Três de Oliveira Quatro', deliv_zip: 12365480,
                deliv_street: 'Rua Condongueira', deliv_number: 105, deliv_nhood: 'Canelas', deliv_city: 'Jocacia', 
                deliv_state: 'MT', km_dist: 102, user: user, status: 0)

    visit root_path
    within('nav') do
      click_on 'Entrar'
    end
    within('form') do
      fill_in 'E-mail', with: user.email
      fill_in 'Senha', with: user.password
      click_on 'Entrar'     
    end
    click_on 'Cotação'
    click_on 'Orçamento'
    click_on 'ABCD12345678912'
    click_on 'Editar'
    fill_in 'Nome do destinatário', with: ''
    click_on 'Cadastrar'

    expect(page).to have_content 'Não foi possível atualizar o pedido'
  end
end
