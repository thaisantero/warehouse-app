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

    it 'cnpj é obrigatório' do
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
  end
end
