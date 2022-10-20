require 'rails_helper'

describe 'Usuário vê estoque' do
  it 'na tela do galpão' do
    user = User.create!(email: 'joao@gmail.com', password: 'password')
    warehouse = Warehouse.create(name: 'Aeroporto de SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', cep: '15000000',
      description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(
      brand_name: 'SAMSUNG', corporate_name: 'SAMSUNG LTDA', registration_number: '22222333000150',
      full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br'
      )
    order = Order.create!(user: user, supplier: supplier,
                          warehouse: warehouse, estimated_delivery_date: 2.day.from_now)
    product_tv = ProductModel.create!(
      name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
      sku: 'TV32-SAMSU-XPT090010', supplier: supplier
    )
    product_soundbar = ProductModel.create!(
      name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, depth: 20,
      sku: 'SOU71-SAMSU-NOIZ7710', supplier: supplier
    )
    product_notebook = ProductModel.create!(
      name: 'Notebook i5 16gb', weight: 2000, width: 40, height: 9, depth: 20,
      sku: 'NOTE5-SAMSU-NOIZ7710', supplier: supplier
    )
    3.times { StockProduct.create!(order: , warehouse:, product_model: product_tv) }
    2.times { StockProduct.create!(order: , warehouse:, product_model: product_notebook) } 

    login_as(user)
    visit root_path
    click_on 'Aeroporto de SP'

    expect(page).to have_content 'Itens em Estoque'
    expect(page).to have_content '3 x TV32-SAMSU-XPT090010'
    expect(page).to have_content '2 x NOTE5-SAMSU-NOIZ7710'
    expect(page).not_to have_content 'SOU71-SAMSU-NOIZ7710'
  end

end