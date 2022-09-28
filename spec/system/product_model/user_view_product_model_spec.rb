require 'rails_helper'

describe 'Usuário vê modelos de produtos' do
  it 'se estiver autenticado' do
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'

    expect(current_path).to eq new_user_session_path
    end
  end

  it 'a partir do menu' do
    user = User.create!(email: 'joao@gmail.com', password: 'password')

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end

    expect(current_path).to eq product_models_path
  end

  it 'com sucesso' do
    user = User.create!(email: 'joao@gmail.com', password: 'password')
    supplier = Supplier.create!(
      brand_name: 'SAMSUNG', corporate_name: 'SAMSUNG LTDA', registration_number: '22222333000150',
      full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br'
      )

    ProductModel.create!(
      name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
      sku: 'TV32-SAMSU-XPT090010', supplier: supplier
    )
    ProductModel.create!(
      name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, depth: 20,
      sku: 'SOU71-SAMSU-NOIZ7710', supplier: supplier
    )

    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end

    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'TV32-SAMSU-XPT090010'
    expect(page).to have_content 'SAMSUNG'
    expect(page).to have_content 'SoundBar 7.1 Surround'
    expect(page).to have_content 'SOU71-SAMSU-NOIZ7710'
  end

  it 'e não existem produtos cadastrados' do
    user = User.create!(email: 'joao@gmail.com', password: 'password')
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end

    expect(page).to have_content 'Não existem produtos cadastrados'
  end
end
