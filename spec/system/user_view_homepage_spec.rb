require 'rails_helper'

describe 'Usuário visualiza tela inicial da Transportadora' do
  it 'e vê o nome do app' do
    visit root_path

    expect(page).to have_content 'Lista de modalidades'
  end

  it 'e vê as modalidade de transportes cadastras' do
    Shipping.create(name: 'Rio', min_dist: 60, max_dist: 120, min_weight: 200, max_weight: 800,
                    deliv_fee: 250, status: 0)
    Shipping.create(name: 'Maceio', min_dist: 70, max_dist: 200, min_weight: 100, max_weight: 500,
                    deliv_fee: 1000, status: 1)

    visit root_path

    expect(page).not_to have_content 'Não existe modalidades de transportes cadastrados'
    expect(page).to have_content 'Rio'
    expect(page).to have_content 'Distância mínima: 60km'
    expect(page).to have_content 'Distância máxima: 120km'
    expect(page).not_to have_content 'Peso mínimo da carga: 200kg'
    expect(page).not_to have_content 'Peso mínimo da carga: 800kg'
    expect(page).not_to have_content 'Tarifa padrão: R$ 250'
    expect(page).to have_content 'Situação: inativo'
    expect(page).to have_content 'Maceio'
    expect(page).to have_content 'Distância mínima: 70km'
    expect(page).to have_content 'Distância máxima: 200km'
    expect(page).not_to have_content 'Peso mínimo da carga: 100kg'
    expect(page).not_to have_content 'Peso mínimo da carga: 500kg'
    expect(page).not_to have_content 'Tarifa padrão: R$ 1000'
    expect(page).to have_content 'Situação: ativo'
  end
  it 'e não existe modalidade de transportes cadastras' do
    visit root_path

    expect(page).not_to have_content 'Não existe modalidades de transportes cadastrados'
  end
end
