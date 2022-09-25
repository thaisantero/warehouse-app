# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário edita um fornecedor' do
  it 'a partir de uma página de detalhes' do
    Supplier.create!(
      corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '12345678000150',
      full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@gmail.com'
    )

    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Editar'

    expect(page).to have_content('Editar Fornecedor')
    expect(page).to have_field('Nome Fantasia', with: 'ACME')
    expect(page).to have_field('Razão Social', with: 'ACME LTDA')
    expect(page).to have_field('CNPJ', with: '12345678000150')
    expect(page).to have_field('Endereço', with: 'Av das Palmas, 100')
    expect(page).to have_field('Cidade', with: 'Bauru')
    expect(page).to have_field('Estado', with: 'SP')
    expect(page).to have_field('E-mail', with: 'contato@gmail.com')
  end

  it 'com sucesso' do
    Supplier.create!(
      corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '12345678000150',
      full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@gmail.com'
    )

    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Editar'
    fill_in 'Nome Fantasia', with: 'ACMEST'
    fill_in 'Razão Social', with: 'ACMEST LTDA'
    click_on 'Enviar'

    expect(page).to have_content('Fornecedor atualizado com sucesso')
    expect(page).to have_content('ACMEST')
    expect(page).to have_content('ACMEST LTDA')
  end

  it 'e mantém os campos obrigatórios' do
    Supplier.create!(
      corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '12345678000150',
      full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@gmail.com'
    )

    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Editar'
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'CNPJ', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível atualizar o fornecedor')
  end
end
