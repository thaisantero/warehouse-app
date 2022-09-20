require 'rails_helper'

describe 'Usuário visita tela inicial' do
  it 'e vê o nome da app' do
    # Arrange

    # Act
    visit('/')
    
    # Assert
    expect(page).to have_content('Galpões & Estoque')
  end

  it 'e vê os galpoes cadastrados' do
    # Arrange
    # cadastrar dois galpoes: Rio e MAceio
    Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: '60_000', address: 'Av Atlantica, 10', cep: '20000-000', description: 'Galpao do Rio')
    Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: '50_000', address: 'Av do Aeroporto, 20', cep: '80000-000', description: 'Galpao de Maceio')
    
    # Act
    visit('/')

    # Assert
    expect(page).not_to have_content('Nao existem galpões cadastrados')
    expect(page).to have_content('Rio')
    expect(page).to have_content('SDU')
    expect(page).to have_content('Rio de Janeiro')
    expect(page).to have_content('60000 m2')

    expect(page).to have_content('Maceio')
    expect(page).to have_content('MCZ')
    expect(page).to have_content('50000 m2')
  end

  it 'e não existem galpões cadastrados' do
    # Arrange
    
    # Act
    visit('/')
    
    # Assert
    expect(page).to have_content('Não existem galpões cadastrados')
  end

end