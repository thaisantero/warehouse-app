# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe 'válido?' do
    context 'presença' do
      it 'falso quando nome está vazio' do
        warehouse = Warehouse.new(name: '', code: 'RIO', address: 'Endereço',
                                  cep: '25000000', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')

        expect(warehouse).not_to be_valid
      end

      it 'falso quando nome código está vazio' do
        warehouse = Warehouse.new(name: 'Rio', code: '', address: 'Endereço',
                                  cep: '25000000', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')

        expect(warehouse).not_to be_valid
      end

      it 'falso quando endereço está vazio' do
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: '',
                                  cep: '25000000', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')

        expect(warehouse).not_to be_valid
      end

      it 'falso quando CEP está vazio' do
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço',
                                  cep: '', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')

        expect(warehouse).not_to be_valid
      end

      it 'falso quando cidade está vazio' do
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço',
                                  cep: '25000000', city: '', area: 1000,
                                  description: 'Alguma descrição')

        expect(warehouse).not_to be_valid
      end

      it 'falso quando área está vazia' do
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço',
                                  cep: '25000000', city: 'Rio', area: '',
                                  description: 'Alguma descrição')

        expect(warehouse).not_to be_valid
      end

      it 'falso quando descrição está vazia' do
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço',
                                  cep: '25000000', city: 'Rio', area: 1000,
                                  description: '')

        expect(warehouse).not_to be_valid
      end
    end

    context 'singularidade dos atributos' do
      it 'falso quando código já foi utilizado' do
        warehouse_first = Warehouse.create(name: 'Rio', code: 'RIO', address: 'Endereço',
                                           cep: '25000000', city: 'Rio', area: 1000,
                                           description: 'Galpão no Rio')
        warehouse_second = Warehouse.new(name: 'Niteroi', code: 'RIO', address: 'Av Niteroi',
                                         cep: '35000000', city: 'Niteroi', area: 2000,
                                         description: 'Galpão em Niteroi')

        expect(warehouse_second).not_to be_valid
      end
    end

    context 'número de dígitos do atributo' do
      it 'falso quando código não tem 3 dígitos' do
        warehouse = Warehouse.create(name: 'Rio', code: 'RI', address: 'Endereço',
                                     cep: '25000000', city: 'Rio', area: 1000,
                                     description: 'Galpão no Rio')

        expect(warehouse).not_to be_valid
      end

      it 'falso quando CEP não tem 8 dígitos' do
        warehouse = Warehouse.create(name: 'Rio', code: 'RIO', address: 'Endereço',
                                     cep: '2500000000', city: 'Rio', area: 1000,
                                     description: 'Galpão no Rio')

        expect(warehouse).not_to be_valid
      end
    end
  end
end
