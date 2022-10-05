require 'rails_helper'

describe 'Usuário vê seus próprios pedidos' do
  it 'e deve estar autenticado' do
    visit root_path
    click_on 'Meus Pedidos'

    expect(current_path).to eq new_user_session_path
  end

  it 'e não vê outros pedidos' do
    first_user = User.create!(name: 'João', email: 'joao@gmail.com', password: 'password')
    second_user = User.create!(name: 'Maria', email: 'maria@gmail.com', password: 'maria123')
    supplier = Supplier.create!(
      brand_name: 'LG', corporate_name: 'LG LTDA', registration_number: '12345333000150',
      full_address: 'Av Ibirapuera, 3000', city: 'São Paulo', state: 'SP', email: 'sac@lg.com.br'
    )
    warehouse = Warehouse.create!(
      name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: '60_000',
      address: 'Av Atlantica, 10',
      cep: '20000000', description: 'Galpao do Rio'
    )
    first_order = Order.create!(user: first_user, supplier: supplier, 
      warehouse: warehouse, estimated_delivery_date: 2.day.from_now, status: 'pending')
    second_order = Order.create!(user: second_user, supplier: supplier, 
      warehouse: warehouse, estimated_delivery_date: 2.day.from_now, status: 'delivered')
    third_order = Order.create!(user: first_user, supplier: supplier, 
      warehouse: warehouse, estimated_delivery_date: 5.day.from_now, status: 'canceled')

    login_as(first_user)
    visit root_path
    click_on 'Meus Pedidos'

    expect(page).to have_content(first_order.code)
    expect(page).to have_content 'Pendente'
    expect(page).not_to have_content(second_order.code)
    expect(page).not_to have_content 'Entregue'
    expect(page).to have_content(third_order.code)
    expect(page).to have_content 'Cancelado'
  end

  it 'e visita um pedido' do
    user = User.create!(name: 'João', email: 'joao@gmail.com', password: 'password')
    supplier = Supplier.create!(
      brand_name: 'LG', corporate_name: 'LG LTDA', registration_number: '12345333000150',
      full_address: 'Av Ibirapuera, 3000', city: 'São Paulo', state: 'SP', email: 'sac@lg.com.br'
    )
    warehouse = Warehouse.create!(
      name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: '60_000',
      address: 'Av Atlantica, 10',
      cep: '20000000', description: 'Galpao do Rio'
    )
    order = Order.create!(user: user, supplier: supplier, warehouse: warehouse, estimated_delivery_date: 2.day.from_now)

    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code

    expect(page).to have_content 'Detalhes do Pedido'
    expect(page).to have_content order.code
    expect(page).to have_content 'Galpão Destino: SDU - Galpão Rio'
    expect(page).to have_content 'Fornecedor: LG LTDA'
    formatted_date = I18n.localize(2.day.from_now.to_date)
    expect(page).to have_content "Data Prevista de Entrega: #{formatted_date}"
  end

  it 'e não visita pedidos de outros usuários' do
    first_user = User.create!(name: 'João', email: 'joao@gmail.com', password: 'password')
    second_user = User.create!(name: 'Maria', email: 'maria@gmail.com', password: 'maria123')
    supplier = Supplier.create!(
      brand_name: 'LG', corporate_name: 'LG LTDA', registration_number: '12345333000150',
      full_address: 'Av Ibirapuera, 3000', city: 'São Paulo', state: 'SP', email: 'sac@lg.com.br'
    )
    warehouse = Warehouse.create!(
      name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: '60_000',
      address: 'Av Atlantica, 10',
      cep: '20000000', description: 'Galpao do Rio'
    )
    order = Order.create!(user: first_user, supplier: supplier,
                          warehouse: warehouse, estimated_delivery_date: 2.day.from_now)

    login_as(second_user)
    visit order_path(order.id)

    expect(current_path).not_to eq order_path(order.id)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui acesso a esta pedido.'
  end

  it 'e vê itens do pedido' do
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
    product_model_C = ProductModel.create!(
      name: 'TV 40', weight: 10000, width: 90, height: 65, depth: 20,
      sku: 'TV40-SAMSU-XPT090010', supplier: supplier
    )

    user = User.create!(name: 'João', email: 'joao@gmail.com', password: 'password')
    warehouse = Warehouse.create!(
      name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: '60_000',
      address: 'Av Atlantica, 10',
      cep: '20000000', description: 'Galpao do Rio'
    )
    order = Order.create!(user: user, supplier: supplier,
                          warehouse: warehouse, estimated_delivery_date: 2.day.from_now)

    OrderItem.create!(product_model: product_model_A, order: order, quantity: 19)
    OrderItem.create!(product_model: product_model_B, order: order, quantity: 12)

    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code

    expect(page).to have_content 'Itens do Pedido'
    expect(page).to have_content '19 x TV 32'
    expect(page).to have_content '12 x SoundBar 7.1 Surround'
    expect(page).not_to have_content 'TV 40'
  end
end
