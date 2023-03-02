require 'rails_helper'

describe 'Usuário lista as Ordens' do
  context 'abertas no sistema estando logado' do
    it 'e vê as ordens pendentes' do
      user_id = User.create(name: 'User', email: 'user@email.com', password: 'pwd123456')
      allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCD12345678912')
      Order.create!(collect_zip: 11_256_360, collect_street: 'Rua um dois três', collect_number: 205,
                    collect_nhood: 'Laranjeiras', collect_city: 'Condongas', collect_state: 'MS', width: 10,
                    height: 12, depth: 13, weight: 82, deliv_reipient: 'Um Dois Três de Oliveira Quatro',
                    deliv_zip: 12_365_480, deliv_street: 'Rua Condongueira', deliv_number: 105,
                    deliv_nhood: 'Canelas', deliv_city: 'Jocacia', deliv_state: 'MT', km_dist: 102,
                    user: user_id, status: 0)

      visit root_path
      login_as(user_id)
      click_on 'Cotação'
      click_on 'Orçamento'

      expect(page).to have_content 'Código identificador:'
      expect(page).to have_content 'ABCD12345678912'
      expect(page).to have_content 'Situação: pendente'
    end
    it 'e não vê pedidos' do
      user_id = User.create(name: 'User', email: 'user@email.com', password: 'pwd123456')
      visit root_path
      login_as(user_id)
      click_on 'Cotação'
      click_on 'Orçamento'

      expect(page).to have_content 'Nenhuma ordem cadastrada neste usuário'
    end
  end
  context 'e não vê pedidos' do
    it 'quando logado com outro usuário' do
      user_id = User.create(name: 'User', email: 'user@email.com', password: 'pwd123456')
      user2 = User.create(name: 'User2', email: 'user2@email.com', password: 'pwd123456')
      allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCD12345678912')
      Order.create!(collect_zip: 11_256_360, collect_street: 'Rua um dois três', collect_number: 205,
                    collect_nhood: 'Laranjeiras', collect_city: 'Condongas', collect_state: 'MS', width: 10,
                    height: 12, depth: 13, weight: 82, deliv_reipient: 'Um Dois Três de Oliveira Quatro',
                    deliv_zip: 12_365_480, deliv_street: 'Rua Condongueira', deliv_number: 105,
                    deliv_nhood: 'Canelas', deliv_city: 'Jocacia', deliv_state: 'MT', km_dist: 102,
                    user: user_id, status: 0)

      visit root_path
      login_as(user2)
      click_on 'Cotação'
      click_on 'Orçamento'

      expect(page).to have_content 'Nenhuma ordem cadastrada neste usuário'
    end
    it 'quando não logado' do
      user_id = User.create(name: 'User', email: 'user@email.com', password: 'pwd123456')
      allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCD12345678912')
      Order.create!(collect_zip: 11_256_360, collect_street: 'Rua um dois três', collect_number: 205,
                    collect_nhood: 'Laranjeiras', collect_city: 'Condongas', collect_state: 'MS', width: 10,
                    height: 12, depth: 13, weight: 82, deliv_reipient: 'Um Dois Três de Oliveira Quatro',
                    deliv_zip: 12_365_480, deliv_street: 'Rua Condongueira', deliv_number: 105,
                    deliv_nhood: 'Canelas', deliv_city: 'Jocacia', deliv_state: 'MT', km_dist: 102,
                    user: user_id, status: 0)

      visit root_path
      click_on 'Cotação'
      click_on 'Orçamento'

      expect(page).to have_content 'Nenhuma ordem cadastrada neste usuário'
    end
  end
end
