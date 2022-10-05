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
end
