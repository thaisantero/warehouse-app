require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe 'válido?' do
    it 'nome é obrigatório' do
      supplier = Supplier.create!(
        brand_name: 'SAMSUNG', corporate_name: 'SAMSUNG LTDA', registration_number: '22222333000150',
        full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br'
      )

      pm = ProductModel.new(
        name: '', weight: 8000, width: 70, height: 45, depth: 10,
        sku: 'TV32-SAMSU-XPT090', supplier: supplier
      )

      result = pm.valid?

      expect(result).to eq false
    end

    it 'sku é obrigatório' do
      supplier = Supplier.create!(
        brand_name: 'SAMSUNG', corporate_name: 'SAMSUNG LTDA', registration_number: '22222333000150',
        full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br'
      )

      pm = ProductModel.new(
        name: 'TV32', weight: 8000, width: 70, height: 45, depth: 10,
        sku: '', supplier: supplier
      )

      result = pm.valid?

      expect(result).to eq false
    end

    it 'peso é obrigatório' do
      supplier = Supplier.create!(
        brand_name: 'SAMSUNG', corporate_name: 'SAMSUNG LTDA', registration_number: '22222333000150',
        full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br'
      )

      pm = ProductModel.new(
        name: 'TV32', weight: '', width: 70, height: 45, depth: 10,
        sku: 'TV32-SAMSU-XPT090', supplier: supplier
      )

      result = pm.valid?

      expect(result).to eq false
    end

    it 'largura é obrigatório' do
      supplier = Supplier.create!(
        brand_name: 'SAMSUNG', corporate_name: 'SAMSUNG LTDA', registration_number: '22222333000150',
        full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br'
      )

      pm = ProductModel.new(
        name: 'TV32', weight: 8000, width: '', height: 45, depth: 10,
        sku: 'TV32-SAMSU-XPT090', supplier: supplier
      )

      result = pm.valid?

      expect(result).to eq false
    end

    it 'altura é obrigatório' do
      supplier = Supplier.create!(
        brand_name: 'SAMSUNG', corporate_name: 'SAMSUNG LTDA', registration_number: '22222333000150',
        full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br'
      )

      pm = ProductModel.new(
        name: 'TV32', weight: 8000, width: 70, height: '', depth: 10,
        sku: 'TV32-SAMSU-XPT090', supplier: supplier
      )

      result = pm.valid?

      expect(result).to eq false
    end

    it 'profundidade é obrigatório' do
      supplier = Supplier.create!(
        brand_name: 'SAMSUNG', corporate_name: 'SAMSUNG LTDA', registration_number: '22222333000150',
        full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br'
      )

      pm = ProductModel.new(
        name: 'TV32', weight: 8000, width: 70, height: 45, depth: '',
        sku: 'TV32-SAMSU-XPT090', supplier: supplier
      )

      result = pm.valid?

      expect(result).to eq false
    end

    it 'sku é único' do
      supplier = Supplier.create!(
        brand_name: 'SAMSUNG', corporate_name: 'SAMSUNG LTDA', registration_number: '22222333000150',
        full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br'
      )

      ProductModel.create!(
        name: 'TV32', weight: 8000, width: 70, height: 45, depth: 10,
        sku: 'TV32-SAMSU-XPT090010', supplier: supplier
      )
      pm = ProductModel.new(
        name: 'TV40', weight: 10000, width: 90, height: 55, depth: 20,
        sku: 'TV32-SAMSU-XPT090010', supplier: supplier
      )

      result = pm.valid?

      expect(result).to eq false
    end

    it 'largura menor que 0' do
      supplier = Supplier.create!(
        brand_name: 'SAMSUNG', corporate_name: 'SAMSUNG LTDA', registration_number: '22222333000150',
        full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br'
      )

      pm = ProductModel.create(
        name: 'TV40', weight: 10, width: -90, height: 55, depth: 20,
        sku: 'TV32-SAMSU-XPT090010', supplier: supplier
      )

      result = pm.valid?

      expect(result).to eq false
    end

    it 'altura menor que 0' do
      supplier = Supplier.create!(
        brand_name: 'SAMSUNG', corporate_name: 'SAMSUNG LTDA', registration_number: '22222333000150',
        full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br'
      )

      pm = ProductModel.create(
        name: 'TV40', weight: 10, width: 90, height: -55, depth: 20,
        sku: 'TV32-SAMSU-XPT090010', supplier: supplier
      )

      result = pm.valid?

      expect(result).to eq false
    end

    it 'profundidade menor que 0' do
      supplier = Supplier.create!(
        brand_name: 'SAMSUNG', corporate_name: 'SAMSUNG LTDA', registration_number: '22222333000150',
        full_address: 'Av Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br'
      )

      pm = ProductModel.create(
        name: 'TV40', weight: -10, width: 90, height: 55, depth: -20,
        sku: 'TV32-SAMSU-XPT090010', supplier: supplier
      )

      result = pm.valid?

      expect(result).to eq false
    end
  end
end
