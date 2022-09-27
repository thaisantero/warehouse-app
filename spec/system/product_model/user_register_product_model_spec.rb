require 'rails_helper'

describe 'Usuário cadastra um modelo de produto' do
  it 'com sucesso' do
    Supplier.create!(
      brand_name: 'SAMSUNG', corporate_name: 'SAMSUNG LTDA', registration_number: '22222333000150',
      full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br'
    )
    Supplier.create!(
      brand_name: 'LG', corporate_name: 'LG LTDA', registration_number: '12345333000150',
      full_address: 'Av Ibirapuera, 3000', city: 'São Paulo', state: 'SP', email: 'sac@lg.com.br'
    )

    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome', with: 'TV 32'
    fill_in 'Peso', with: 8000
    fill_in 'Largura', with: 70
    fill_in 'Altura', with: 45
    fill_in 'Profundidade', with: 10
    fill_in 'SKU', with: 'TV32-SAMSU-XPT090'
    select 'SAMSUNG', from: 'Fornecedor'
    click_on 'Enviar'

    expect(page).to have_content('Modelo de Produto cadastrado com sucesso.')
    expect(page).to have_content('TV 32')
    expect(page).to have_content('Dimensão: 45cm x 70cm x 10cm')
    expect(page).to have_content('SKU: TV32-SAMSU-XPT090')
    expect(page).to have_content('Peso: 8000g')
    expect(page).to have_content('Fornecedor: SAMSUNG')
  end

  it 'com campos imcompletos' do
    Supplier.create!(
      brand_name: 'SAMSUNG', corporate_name: 'SAMSUNG LTDA', registration_number: '22222333000150',
      full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br'
    )

    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo'
    fill_in 'Nome', with: ''
    fill_in 'Peso', with: ''
    fill_in 'SKU', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível cadastrar o modelo de produto.')
  end
end
