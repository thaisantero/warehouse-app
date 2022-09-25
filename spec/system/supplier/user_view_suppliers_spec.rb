require 'rails_helper'

describe 'Usuário vê fornecedores' do
  it 'a partir do menu' do

    visit root_path
    click_on 'Fornecedores'

    expect(current_path).to eq suppliers_path
  end

  
end