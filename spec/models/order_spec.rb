require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'deve ter um código' do
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
      order = Order.new(user: user, supplier: supplier, warehouse: warehouse, estimated_delivery_date: 2.day.from_now)

      result = order.valid?

      expect(result).to be true
    end

    it 'data estimada de entrega deve ser obrigatória' do
      order = Order.new(estimated_delivery_date: '')

      order.valid?
      result = order.errors.include? :estimated_delivery_date

      expect(result).to be true
    end

    it 'data estimada de entrega não pode ser passada' do
      order = Order.new(estimated_delivery_date: 1.day.ago)

      order.valid?

      expect(order.errors.include? :estimated_delivery_date).to be true
      expect(order.errors[:estimated_delivery_date]).to include 'deve ser futura.'
    end

    it 'data estimada de entrega não pode ser hoje' do
      order = Order.new(estimated_delivery_date: Date.today)

      order.valid?

      expect(order.errors.include? :estimated_delivery_date).to be true
      expect(order.errors[:estimated_delivery_date]).to include 'deve ser futura.'
    end

    it 'data estimada de entrega deve ser igual ou maior do que amanhã' do
      order = Order.new(estimated_delivery_date: 1.day.from_now)

      order.valid?

      expect(order.errors.include? :estimated_delivery_date).to be false
    end
  end

  describe 'gera um código aleatório' do
    it 'ao criar um novo pedido' do
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
      order = Order.new(user: user, supplier: supplier, warehouse: warehouse, estimated_delivery_date: 2.day.from_now)

      order.save!
      result = order.code

      expect(result).not_to be_empty
      expect(result.length).to eq 10
    end

    it 'e único' do
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
      first_order = Order.create!(
        user: user, supplier: supplier,
        warehouse: warehouse, estimated_delivery_date: 2.day.from_now
      )
      second_order = Order.new(
        user: user, supplier: supplier,
        warehouse: warehouse, estimated_delivery_date: 2.day.from_now
      )

      second_order.save!

      expect(second_order.code).not_to eq first_order.code
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
      order = Order.create!(
        user: user, supplier: supplier,
        warehouse: warehouse, estimated_delivery_date: 2.day.from_now
      )
      original_code = order.code

      order.update!(estimated_delivery_date: 1.month.from_now)

      expect(order.code).to eq original_code
    end
  end
end
