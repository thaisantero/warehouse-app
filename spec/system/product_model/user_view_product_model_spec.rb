require 'rails_helper'

describe 'Usuário vê modelos de de produtos' do
  it 'a partir do menu' do
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end

    expect(current_path).to eq product_models_path
  end

  it 'com sucesso' do
    supplier = Supplier.create!(
      brand_name: 'SAMSUNG', corporate_name: 'SAMSUNG LTDA', registration_number: '22222333000150',
      full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br'
      )

    ProductModel.create!(
      name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
      sku: 'TV32-SAMSU-XPT090', supplier: supplier
    )
    ProductModel.create!(
      name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, depth: 20,
      sku: 'SOU71-SAMSU-NOIZ77', supplier: supplier
    )

    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end

    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'TV32-SAMSU-XPT090'
    expect(page).to have_content 'SAMSUNG'
    expect(page).to have_content 'SoundBar 7.1 Surround'
    expect(page).to have_content 'SOU71-SAMSU-NOIZ77'
  end

  it 'e não existem produtos cadastrados' do
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end

    expect(page).to have_content 'Não existem produtos cadastrados'
  end
end
