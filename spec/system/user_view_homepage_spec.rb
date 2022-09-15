require 'rails_helper'

describe 'Usuario visita tela inicial' do
  it 'e ve o nome da app' do
    # Arrange

    # Act
    visit('/')
    
    # Assert
    expect(page).to have_content('Galpões & Estoque')
  end

  it 'e ve os galpoes cadastrados' do
    # Arrange
    # cadastrar dois galpoes: Rio e MAceio
    Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: '60_000')
    Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: '50_000')
    
    # Act
    visit('/')
    
    # Assert
    expect(page).not_to have_content('Nao existem galpoes cadastrados')
    expect(page).to have_content('Rio')
    expect(page).to have_content('SDU')
    expect(page).to have_content('Rio de Janeiro')
    expect(page).to have_content('60000 m2')

    expect(page).to have_content('Maceio')
    expect(page).to have_content('MCZ')
    expect(page).to have_content('50000 m2')
  end

  it 'e nao existem galpoes cadastrados' do
    # Arrange
    
    # Act
    visit('/')
    
    # Assert
    expect(page).to have_content('Nao existem galpoes cadastrados')
  end

end