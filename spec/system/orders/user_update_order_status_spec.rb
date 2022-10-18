require 'rails_helper'

describe 'Usuário informa novo status do pedido' do
  it 'e pedido foi entregue' do
    user = User.create!(name: 'João', email: 'joao@gmail.com', password: 'password')
    supplier = Supplier.create!(
      brand_name: 'LG', corporate_name: 'LG LTDA', registration_number: '12345333000150',
      full_address: 'Av Ibirapuera, 3000', city: 'São Paulo', state: 'SP', email: 'sac@lg.com.br'
    )
    warehouse = Warehouse.create!(
      name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: '50_000',
      address: 'Av do Aeroporto, 20',
      cep: '80000000', description: 'Galpao de Maceio'
    )
    order = Order.create!(
      user: user, supplier: supplier,
      warehouse: warehouse, estimated_delivery_date: 2.day.from_now, status: :pending
    )
    product = ProductModel.create!(
      name: 'Cadeira Gamer', weight: 5000, width: 80, height: 100, depth: 75,
      sku: 'CADEIRA-GAMERX-12345', supplier: supplier
    )
    OrderItem.create!(order:, product_model: product, quantity: 5)

    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como ENTREGUE'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação do Pedido: Entregue'
    expect(page).not_to have_content 'Marcar como CANCELADO'
    expect(page).not_to have_content 'Marcar como ENTREGUE'
    expect(StockProduct.count).to eq 5
    stock = StockProduct.where(product_model: product, warehouse:warehouse).count
    expect(stock).to eq 5
  end

  it 'e pedido foi cancelado' do
    user = User.create!(name: 'João', email: 'joao@gmail.com', password: 'password')
    supplier = Supplier.create!(
      brand_name: 'LG', corporate_name: 'LG LTDA', registration_number: '12345333000150',
      full_address: 'Av Ibirapuera, 3000', city: 'São Paulo', state: 'SP', email: 'sac@lg.com.br'
    )
    warehouse = Warehouse.create(
      name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: '50_000',
      address: 'Av do Aeroporto, 20',
      cep: '80000000', description: 'Galpao de Maceio'
    )
    order = Order.create!(
      user: user, supplier: supplier,
      warehouse: warehouse, estimated_delivery_date: 2.day.from_now, status: :pending
    )
    product = ProductModel.create!(
      name: 'Cadeira Gamer', weight: 5000, width: 80, height: 100, depth: 75,
      sku: 'CADEIRA-GAMERX-12345', supplier: supplier
    )
    OrderItem.create!(order:, product_model: product, quantity: 5)

    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como CANCELADO'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Situação do Pedido: Cancelado'
    expect(page).not_to have_content 'Marcar como CANCELADO'
    expect(page).not_to have_content 'Marcar como ENTREGUE'
    expect(StockProduct.count).to eq 0
  end
end
