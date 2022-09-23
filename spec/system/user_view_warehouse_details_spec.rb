require 'rails_helper'

describe 'Usuário ve detalhes de um galpao' do

  it 'e vê informações adicionais' do
    # Arrange
    Warehouse.create(name: 'Aeroporto de SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                    address: 'Avenida do Aeroporto, 1000', cep: '15000000',
                    description: 'Galpão destinado para cargas internacionais')
    # Act
    visit(root_path)
    click_on('Aeroporto de SP')

    # Assert
    expect(page).to have_content('Galpão GRU')
    expect(page).to have_content('Nome: Aeroporto de SP')
    expect(page).to have_content('Cidade: Guarulhos')
    expect(page).to have_content('Área: 100000 m2')
    expect(page).to have_content('Endereço: Avenida do Aeroporto, 1000 CEP: 15000-000')
    expect(page).to have_content('Galpão destinado para cargas internacionais')
  end

  it 'e volta para a tela inicial' do
    # Arrange
    Warehouse.create(name: 'Aeroporto de SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
          address: 'Avenida do Aeroporto, 1000', cep: '15000000',
          description: 'Galpão destinado para cargas internacionais')
    # Act
    visit(root_path)
    click_on('Aeroporto de SP')
    click_on('Voltar')

    # Assert
    expect(current_path).to have_content(root_path)
  end
end 