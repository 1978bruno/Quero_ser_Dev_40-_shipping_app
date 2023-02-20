require 'rails_helper'

describe 'Usuário busca pela modalidade' do
  it 'a partir do menu' do
    visit root_path

    expect(page).to have_field('Buscar Modalidade')
    expect(page).to have_button('Buscar')
  end
  it 'e encontra uma modalidade' do
    Shipping.create!(name: 'Rio', min_dist: 60, max_dist: 120, min_weight: 200, max_weight: 800,
                     deliv_fee: 250, status: 0)
    Shipping.create!(name: 'Maceio', min_dist: 70, max_dist: 200, min_weight: 100, max_weight: 500,
                     deliv_fee: 1000, status: 1)

    visit root_path
    fill_in 'Buscar Modalidade', with: 'Maceio'
    click_on 'Buscar'

    expect(page).not_to have_content('Não existe modalidades de transportes cadastrados')
    expect(page).to have_content("Nome\nMaceio")
    expect(page).to have_content('Distância mínima: 70km')
    expect(page).to have_content('Distância máxima: 200km')
    expect(page).to have_content('Situação: ativo')
  end
  it 'e encontra multiplas modalidades' do
    Shipping.create!(name: 'Rio', min_dist: 60, max_dist: 120, min_weight: 200, max_weight: 800,
                     deliv_fee: 250, status: 0)
    Shipping.create!(name: 'Maceio', min_dist: 70, max_dist: 200, min_weight: 100, max_weight: 500,
                     deliv_fee: 1000, status: 1)
    Shipping.create!(name: 'Maceio', min_dist: 201, max_dist: 300, min_weight: 100, max_weight: 500,
                     deliv_fee: 2000, status: 1)
    Shipping.create!(name: 'Maceio', min_dist: 301, max_dist: 400, min_weight: 100, max_weight: 500,
                     deliv_fee: 3000, status: 0)

    visit root_path
    fill_in 'Buscar Modalidade', with: 'Maceio'
    click_on 'Buscar'

    expect(page).not_to have_content('Não existe modalidades de transportes cadastrados')
    expect(page).to have_content '3 Transportes Encontrados'
    expect(page).to have_content("Nome\nMaceio")
    expect(page).to have_content('Distância mínima: 70km')
    expect(page).to have_content('Distância máxima: 200km')
    expect(page).to have_content('Situação: ativo')

    expect(page).to have_content('Distância mínima: 201km')
    expect(page).to have_content('Distância máxima: 300km')

    expect(page).to have_content('Distância mínima: 301km')
    expect(page).to have_content('Distância máxima: 400km')
    expect(page).to have_content('Situação: inativo')
  end
  it 'e acessa os detalhes da modalidade escolhida' do
    shipping1 = Shipping.create!(name: 'Rio', min_dist: 60, max_dist: 120, min_weight: 200, max_weight: 800,
                                 deliv_fee: 250, status: 0)
    shipping2 = Shipping.create!(name: 'Maceio', min_dist: 70, max_dist: 200, min_weight: 100, max_weight: 500,
                                 deliv_fee: 1000, status: 1)
    shipping3 = Shipping.create!(name: 'Maceio', min_dist: 201, max_dist: 300, min_weight: 100, max_weight: 500,
                                 deliv_fee: 2000, status: 1)
    shipping4 = Shipping.create!(name: 'Maceio', min_dist: 301, max_dist: 400, min_weight: 100, max_weight: 500,
                                 deliv_fee: 3000, status: 0)
    Cost.create!(int_min_weight: 125, int_max_weight: 150, km_value: 15, shipping: shipping1)
    Cost.create!(int_min_weight: 1125, int_max_weight: 1150, km_value: 115, shipping: shipping2)
    Cost.create!(int_min_weight: 2125, int_max_weight: 2150, km_value: 215, shipping: shipping3)
    Cost.create!(int_min_weight: 3125, int_max_weight: 3150, km_value: 315, shipping: shipping4)
    DelivTerm.create!(term_int_min_weight: 125, term_int_max_weight: 150, deliv_term: 15, shipping: shipping1)
    DelivTerm.create!(term_int_min_weight: 1125, term_int_max_weight: 1150, deliv_term: 115, shipping: shipping2)
    DelivTerm.create!(term_int_min_weight: 2125, term_int_max_weight: 2150, deliv_term: 215, shipping: shipping3)
    DelivTerm.create!(term_int_min_weight: 3125, term_int_max_weight: 3150, deliv_term: 315, shipping: shipping4)

    visit root_path
    fill_in 'Buscar Modalidade', with: 'Rio'
    click_on 'Buscar'
    click_on 'Rio'

    expect(page).to have_content('Nome da Modalidade: Rio')
    expect(page).to have_content('Distância mínima: 60km')
    expect(page).to have_content('Distância máxima: 120km')
    expect(page).to have_content('Peso mínimo da carga: 200kg')
    expect(page).to have_content('Peso máximo da carga: 800kg')
    expect(page).to have_content('Tarifa padrão: R$ 250')
    expect(page).to have_content('Situação: inativo')
  end
end
