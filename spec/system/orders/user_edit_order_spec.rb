require 'rails_helper'

describe 'Usuário edita um pedido' do
  it 'e deve estar autenticada' do
    first_user = User.create!(name: 'João', email: 'joao@gmail.com', password: 'password')
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

    visit edit_order_path(order.id)

    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    first_user = User.create!(name: 'João', email: 'joao@gmail.com', password: 'password')
    supplier = Supplier.create!(
      brand_name: 'LG', corporate_name: 'LG LTDA', registration_number: '12345333000150',
      full_address: 'Av Ibirapuera, 3000', city: 'São Paulo', state: 'SP', email: 'sac@lg.com.br'
    )
    Supplier.create!(
      corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '12345678000150',
      full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@gmail.com'
    )
    warehouse = Warehouse.create!(
      name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: '60_000',
      address: 'Av Atlantica, 10',
      cep: '20000000', description: 'Galpao do Rio'
    )
    order = Order.create!(user: first_user, supplier: supplier,
                          warehouse: warehouse, estimated_delivery_date: 2.day.from_now)

    login_as(first_user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Editar'
    fill_in 'Data Prevista de Entrega', with: '12/12/2022'
    select 'ACME LTDA', from: 'Fornecedor'
    click_on 'Gravar'

    expect(page).to have_content 'Pedido atualizado com sucesso.'
    expect(page).to have_content 'Fornecedor: ACME LTDA'
    expect(page).to have_content 'Data Prevista de Entrega: 12/12/2022'
  end

  it 'caso seja o responsável' do
    first_user = User.create!(name: 'João', email: 'joao@gmail.com', password: 'password')
    second_user = User.create!(name: 'Maria', email: 'maria@gmail.com', password: 'password')
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
    visit edit_order_path(order.id)

    expect(current_path).to eq root_path
  end
end
