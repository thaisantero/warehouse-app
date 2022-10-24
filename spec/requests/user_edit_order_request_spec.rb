require 'rails_helper'

describe 'Usuário edita pedido' do 
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
    patch(order_path(order.id), params: { order: { supplier_id: 3 }})

    expect(response).to redirect_to(root_path)
  end
end
