# frozen_string_literal: true

require 'rails_helper'

describe 'Usuário remove galpão' do
  it 'com sucesso' do
    Warehouse.create(name: 'Aeroporto de SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                     address: 'Avenida do Aeroporto, 1000', cep: '15000000',
                     description: 'Galpão destinado para cargas internacionais')

    visit root_path
    click_on 'Aeroporto de SP'
    click_on 'Remover'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).not_to have_content 'Aeroporto de SP'
    expect(page).not_to have_content 'GRU'
    expect(page).not_to have_content '100000'
  end
end
