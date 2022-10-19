require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'gera um código aleatório' do
    it 'ao criar um StockProduct' do
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
      order = Order.create!(user: user, supplier: supplier, warehouse: warehouse, estimated_delivery_date: 2.day.from_now,
                           status: :delivered)
      product = ProductModel.create!(
        name: 'Cadeira Gamer', weight: 5000, width: 80, height: 100, depth: 75,
        sku: 'CADEIRA-GAMERX-12345', supplier: supplier
      )
      OrderItem.create!(order:, product_model: product, quantity: 5)

      stock_product = StockProduct.create!(warehouse:, product_model: product, order:)

      expect(stock_product.serial_number.length).to eq 20
    end

    it 'e não é modificado' do
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
      other_warehouse = Warehouse.create!(
        name: 'Aeroporto de SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
        address: 'Avenida do Aeroporto, 1000', cep: '15000000',
        description: 'Galpão destinado para cargas internacionais'
      )
      order = Order.create!(user: user, supplier: supplier, warehouse: warehouse, estimated_delivery_date: 2.day.from_now,
                           status: :delivered)
      product = ProductModel.create!(
        name: 'Cadeira Gamer', weight: 5000, width: 80, height: 100, depth: 75,
        sku: 'CADEIRA-GAMERX-12345', supplier: supplier
      )
      OrderItem.create!(order:, product_model: product, quantity: 5)

      stock_product = StockProduct.create!(warehouse:, product_model: product, order:)
      original_serial_number = stock_product.serial_number

      stock_product.update!(warehouse: other_warehouse)

      expect(stock_product.serial_number).to eq original_serial_number
    end
  end
end
