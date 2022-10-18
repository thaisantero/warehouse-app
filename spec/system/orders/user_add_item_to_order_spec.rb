require 'rails_helper'

describe 'Usuário adiciona itens ao pedido' do
  it 'com sucesso' do
    user = User.create!(name: 'João', email: 'joao@gmail.com', password: 'password')
    supplier = Supplier.create!(
      brand_name: 'LG', corporate_name: 'LG LTDA', registration_number: '12345333000150',
      full_address: 'Av Ibirapuera, 3000', city: 'São Paulo', state: 'SP', email: 'sac@lg.com.br'
    )
    product_model_A = ProductModel.create!(
      name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
      sku: 'TV32-SAMSU-XPT090010', supplier: supplier
    )
    product_model_B = ProductModel.create!(
      name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, depth: 20,
      sku: 'SOU71-SAMSU-NOIZ7710', supplier: supplier
    )
    warehouse = Warehouse.create!(
      name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: '60_000',
      address: 'Av Atlantica, 10',
      cep: '20000000', description: 'Galpao do Rio'
    )
    order = Order.create!(user:, supplier:,
                          warehouse:, estimated_delivery_date: 2.day.from_now)

    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'
    select 'TV 32', from: 'Produto'
    fill_in 'Quantidade', with: 8
    click_on 'Gravar'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Item adicionado com sucesso'
    expect(page).to have_content '8 x TV 32'
  end

  it 'não vê produtos de outro fornecedor' do
    user = User.create!(name: 'João', email: 'joao@gmail.com', password: 'password')
    supplier_a = Supplier.create!(
      brand_name: 'LG', corporate_name: 'LG LTDA', registration_number: '12345333000150',
      full_address: 'Av Ibirapuera, 3000', city: 'São Paulo', state: 'SP', email: 'sac@lg.com.br'
    )
    supplier_b = Supplier.create!(
      corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '12345678000150',
      full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@gmail.com'
    )    
    product_model_A = ProductModel.create!(
      name: 'Produto A', weight: 8000, width: 70, height: 45, depth: 10,
      sku: 'TV32-SAMSU-XPT090010', supplier: supplier_a
    )
    product_model_B = ProductModel.create!(
      name: 'Produto B', weight: 3000, width: 80, height: 15, depth: 20,
      sku: 'SOU71-SAMSU-NOIZ7710', supplier: supplier_b
    )
    warehouse = Warehouse.create!(
      name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: '60_000',
      address: 'Av Atlantica, 10',
      cep: '20000000', description: 'Galpao do Rio'
    )
    order = Order.create!(user:, supplier: supplier_a,
                          warehouse:, estimated_delivery_date: 2.day.from_now)

    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'

    expect(page).to have_content 'Produto A'
    expect(page).not_to have_content 'Produto B'
  end
end
