require 'rails_helper'

describe 'Usuário visualiza datalhes de uma modalidade de transporte' do
  it 'e vê informações adicionais' do
    s = Shipping.new(name: 'Rio', min_dist: 60, max_dist: 120, min_weight: 200, max_weight: 800, 
                     deliv_fee: 250)
    s.save()
   
    visit(root_path)
    click_on('Rio')

    expect(page).to have_content('Nome da Modalidade: Rio')
    expect(page).to have_content('Distância mínima: 60km')
    expect(page).to have_content('Distância máxima: 120km')
    expect(page).to have_content('Peso mínimo da carga: 200kg')
    expect(page).to have_content('Peso mínimo da carga: 800kg')
    expect(page).to have_content('Tarifa padrão: R$ 250')

  end
  it 'e volta para a tela inicial' do
    s = Shipping.new(name: 'Rio', min_dist: 60, max_dist: 120, min_weight: 200, max_weight: 800, 
                    deliv_fee: 250)
    s.save() 

    visit(root_path)
    click_on 'Rio'
    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end

end