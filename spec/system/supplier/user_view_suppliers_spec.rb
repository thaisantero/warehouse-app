require 'rails_helper'

describe 'Usuário vê fornecedores' do
  it 'a partir do menu' do
    visit root_path
    click_on 'Fornecedores'

    expect(current_path).to eq suppliers_path
  end

  it 'com sucesso' do
    Supplier.create!(
      corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '123435678',
      full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@gmail.com'
    )
    Supplier.create!(
      corporate_name: 'Spark Industries Brasil', brand_name: 'Spark', registration_number: '34567891',
      full_address: 'Terra da Indústria, 12', city: 'Teresina', state: 'PI', email: 'contato_spark@gmail.com'
    )

    visit root_path
    click_on 'Fornecedores'

    expect(page).to have_content 'ACME'
    expect(page).to have_content 'Bauru - SP'
    expect(page).to have_content 'Spark'
    expect(page).to have_content 'Teresina'
  end

  it 'e não existem fornecedores cadastrados' do
    visit root_path
    click_on 'Fornecedores'

    expect(page).to have_content('Não existem fornecedores cadastrados')
  end
end
