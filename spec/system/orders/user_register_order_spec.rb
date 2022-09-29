require 'rails_helper'

describe 'Usuário cadastra um pedido' do
  it 'e deve ser autenticado' do
    visit root_path
    click_on 'Registrar Pedido'

    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    user = User.create!(name: 'João', email: 'joao@gmail.com', password: 'password')
    Supplier.create!(
      brand_name: 'SAMSUNG', corporate_name: 'SAMSUNG LTDA', registration_number: '22222333000150',
      full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br'
    )
    supplier = Supplier.create!(
      brand_name: 'LG', corporate_name: 'LG LTDA', registration_number: '12345333000150',
      full_address: 'Av Ibirapuera, 3000', city: 'São Paulo', state: 'SP', email: 'sac@lg.com.br'
    )
    Warehouse.create(
      name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: '60_000',
      address: 'Av Atlantica, 10',
      cep: '20000000', description: 'Galpao do Rio'
    )
    warehouse = Warehouse.create(
      name: 'Galpão Maceio', code: 'MCZ', city: 'Maceio', area: '50_000',
      address: 'Av do Aeroporto, 20',
      cep: '80000000', description: 'Galpao de Maceio'
    )

    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select warehouse.name, from: 'Galpão Destino'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in 'Data Prevista de Enrtega', with: '20/12/2022'
    click_on 'Gravar'

    expect(page).to have_content 'Pedido registrado com sucesso.'
    expect(page).to have_content 'Galpão Destino: Galpão Maceio'
    expect(page).to have_content 'Fornecedor: LG LTDA'
    expect(page).to have_content 'Data Prevista de Entrega: 20/12/2022'
    expect(page).to have_content 'Usuário Responsável: João | joao@gmail.com'
    expect(page).not_to have_content 'Galpão Rio'
    expect(page).not_to have_content 'SAMSUNG LTDA'
  end
end