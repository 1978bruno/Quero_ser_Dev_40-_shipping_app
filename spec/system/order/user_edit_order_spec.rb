require 'rails_helper'

describe 'Usuário navega até os detalhes da modalidade de transporte' do
  it 'e edita o cadastro' do
    user = User.create!(name: 'User', email: 'user@email.com', password: 'pwd123456')
    code = allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('ABCD12345678912')
    Order.create!(collect_zip: 11256360, collect_street: 'Rua um dois três', collect_number: 205, 
                collect_nhood: 'Laranjeiras', collect_city: 'Condongas', collect_state: 'MS', width: 10, height: 12, 
                depth: 13, weight: 82, deliv_reipient: 'Um Dois Três de Oliveira Quatro', deliv_zip: 12365480,
                deliv_street: 'Rua Condongueira', deliv_number: 105, deliv_nhood: 'Canelas', deliv_city: 'Jocacia', 
                deliv_state: 'MT', km_dist: 102, user_id: user.id, status: 0)
    shipping0 = Shipping.create!(name: 'Rio', min_dist: 60, max_dist: 120, min_weight: 200, max_weight: 800,
                                 deliv_fee: 250)
    Cost.create!(int_min_weight: 125, int_max_weight: 150, km_value: 15, shipping: shipping0)
    DelivTerm.create!(term_int_min_weight: 125, term_int_max_weight: 150, deliv_term: 15, shipping: shipping0)

    visit root_path
    click_on 'Cotação'
    click_on 'Orçamento'
    click_on 'ABCD12345678912'
    click_on 'Editar ordem'
    fill_in 'Nome do destinatário', with: 'Usuário Completo 2'
    click_on 'Cadastrar'

    expect(page).to have_content('Nome do destinatário: Usuário Completo 2')
    expect(page).not_to have_content('Nome do destinatário: Um Dois Três de Oliveira Quatro')
  end
end
