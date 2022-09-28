# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário vê detalhes de um fornecedor' do
  it 'e vê informações adicionais' do
    # Arrange
    user = User.create!(email: 'joao@gmail.com', password: 'password')
    Supplier.create!(
      corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '12345678000150',
      full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@gmail.com'
    )
    # Act
    login_as(user)
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'

    # Assert
    expect(page).to have_content('ACME LTDA')
    expect(page).to have_content('Documento: 12.345.678/0001-50')
    expect(page).to have_content('Endereço: Av das Palmas, 100 - Bauru - SP')
    expect(page).to have_content('E-mail: contato@gmail.com')
  end

  it 'e volta para a tela inicial' do
    # Arrange
    user = User.create!(email: 'joao@gmail.com', password: 'password')
    Supplier.create!(
      corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '12345678000150',
      full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@gmail.com'
    )
    # Act
    login_as(user)
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Voltar'

    # Assert
    expect(current_path).to have_content(root_path)
  end

  it 'e modelos de produtos cadastrados no fornecedor' do
    # Arrange
    user = User.create!(email: 'joao@gmail.com', password: 'password')
    supplier = Supplier.create!(
      corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '12345678000150',
      full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@gmail.com'
    )

    ProductModel.create!(
      name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
      sku: 'TV32-SAMSU-XPT090010', supplier: supplier
    )
    ProductModel.create!(
      name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, depth: 20,
      sku: 'SOU71-SAMSU-NOIZ7710', supplier: supplier
    )

    # Act
    login_as(user)
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'

    # Assert
    expect(page).to have_content('TV 32')
    expect(page).to have_content('TV32-SAMSU-XPT090010')
    expect(page).to have_content('SoundBar 7.1 Surround')
    expect(page).to have_content('SOU71-SAMSU-NOIZ7710')
  end
end
