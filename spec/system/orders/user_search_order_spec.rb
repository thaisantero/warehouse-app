require 'rails_helper'

describe 'Usuário busca um pedido' do
  it 'a partir do menu' do
    user = User.create!(name: 'João', email: 'joao@gmail.com', password: 'password')

    login_as(user)
    visit root_path
    within('header nav') do
      expect(page).to have_field('Buscar Pedido')
      expect(page).to have_button('Buscar')
    end
  end

  it 'e deve estar autenticado' do
    visit root_path
    within('header nav') do
      expect(page).not_to have_field('Buscar Pedido')
      expect(page).not_to have_button('Buscar')
    end
  end

  it 'e encontra pedido' do
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
    order = Order.create!(user: user, supplier: supplier, warehouse: warehouse, estimated_delivery_date: 2.day.from_now)

    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'

    expect(page).to have_content "Resultados da Busca por: #{order.code}"
    expect(page).to have_content '1 pedido encontrado'
    expect(page).to have_content "Código: #{order.code}"
    expect(page).to have_content 'Galpão Destino: MCZ - Galpão Maceio'
    expect(page).to have_content 'Fornecedor: LG LTDA'
  end

  it 'e encontra múltiplos pedidos' do
    user = User.create!(name: 'João', email: 'joao@gmail.com', password: 'password')
    supplier = Supplier.create!(
      brand_name: 'LG', corporate_name: 'LG LTDA', registration_number: '12345333000150',
      full_address: 'Av Ibirapuera, 3000', city: 'São Paulo', state: 'SP', email: 'sac@lg.com.br'
    )
    first_warehouse = Warehouse.create!(
      name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: '60_000',
      address: 'Av Atlantica, 10',
      cep: '20000000', description: 'Galpao do Rio'
    )
    second_warehouse = Warehouse.create!(
      name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: '50_000',
      address: 'Av do Aeroporto, 20',
      cep: '80000000', description: 'Galpao de Maceio'
    )
    allow(SecureRandom).to receive(:alphanumeric).and_return('RIO1234567')
    order = Order.create!(user: user, supplier: supplier, warehouse: first_warehouse, estimated_delivery_date: 2.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).and_return('RIO0000000')
    order = Order.create!(user: user, supplier: supplier, warehouse: first_warehouse, estimated_delivery_date: 2.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).and_return('MCZ1234567')
    order = Order.create!(user: user, supplier: supplier, warehouse: second_warehouse, estimated_delivery_date: 2.day.from_now)

    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: 'RIO'
    click_on 'Buscar'

    expect(page).to have_content '2 pedidos encontrado'
    expect(page).to have_content 'RIO1234567'
    expect(page).to have_content 'RIO0000000'
    expect(page).to have_content 'Galpão Destino: SDU - Galpão Rio'
    expect(page).not_to have_content 'MCZ1234567'
    expect(page).not_to have_content 'Galpão Destino: MCZ - Galpão Maceio'
  end
end
