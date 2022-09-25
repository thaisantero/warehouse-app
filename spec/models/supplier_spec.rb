require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe 'válido?' do
    context 'presença' do
      it 'falso quando razão social está vazia' do
        supplier = Supplier.new(
          corporate_name: '', brand_name: 'ACME', registration_number: '12345678000150',
          full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@gmail.com'
        )

        expect(supplier).not_to be_valid
      end

      it 'falso quando nome fantasia está vazio' do
        supplier = Supplier.new(
          corporate_name: 'ACME LTDA', brand_name: '', registration_number: '12345678000150',
          full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@gmail.com'
        )

        expect(supplier).not_to be_valid
      end

      it 'falso quando CNPJ está vazio' do
        supplier = Supplier.new(
          corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '',
          full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@gmail.com'
        )

        expect(supplier).not_to be_valid
      end

      it 'falso quando endereço está vazio' do
        supplier = Supplier.new(
          corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '12345678000150',
          full_address: '', city: 'Bauru', state: 'SP', email: 'contato@gmail.com'
        )

        expect(supplier).not_to be_valid
      end

      it 'falso quando cidade está vazio' do
        supplier = Supplier.new(
          corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '12345678000150',
          full_address: 'Av das Palmas, 100', city: '', state: 'SP', email: 'contato@gmail.com'
        )

        expect(supplier).not_to be_valid
      end

      it 'falso quando estado está vazio' do
        supplier = Supplier.new(
          corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '12345678000150',
          full_address: 'Av das Palmas, 100', city: 'Bauru', state: '', email: 'contato@gmail.com'
        )

        expect(supplier).not_to be_valid
      end

      it 'falso quando email está vazia' do
        supplier = Supplier.new(
          corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '12345678000150',
          full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: ''
        )

        expect(supplier).not_to be_valid
      end
    end

    context 'singularidade dos atributos' do
      it 'falso quando CNPJ já foi utilizado' do
        Supplier.create(
          corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '12345678000150',
          full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@gmail.com'
        )
        second_supplier = Supplier.new(
          corporate_name: 'Spark Industries Brasil', brand_name: 'Spark', registration_number: '12345678000150',
          full_address: 'Terra da Indústria, 12', city: 'Teresina', state: 'PI', email: 'contato_spark@gmail.com'
        )

        expect(second_supplier).not_to be_valid
      end
    end

    context 'número de dígitos do atributo' do
      it 'falso quando CNPJ não tem 14 dígitos' do
        supplier = Supplier.create(
          corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '1234567',
          full_address: 'Av das Palmas, 100', city: 'Bauru', state: 'SP', email: 'contato@gmail.com'
        )

        expect(supplier).not_to be_valid
      end
    end
  end
end
