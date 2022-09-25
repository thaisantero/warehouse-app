require 'rails_helper'

describe 'Usuário vê detalhes de um fornecedor' do

  it 'e vê informações adicionais' do
    # Arrange
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name:'ACME', registration_number:'123435678', 
                    full_address:'Av das Palmas, 100', city:'Bauru', state:'SP', email:'contato@gmail.com')
    # Act
    visit root_path
    click_on 'ACME'

    # Assert
    expect(page).to have_content('ACME LTDA')
    expect(page).to have_content('Documento: 123435678')
    expect(page).to have_content('Endereço: Av das Palmas, 100 - Bauru - SP')
    expect(page).to have_content('E-mail: contato@gmail.com')
  end
end