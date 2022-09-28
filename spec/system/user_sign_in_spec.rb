require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    User.create!(email: 'joao@gmail.com', password: 'password')

    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'joao@gmail.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    expect(page).to have_content 'Login efetuado com sucesso.'
    within('nav') do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_link 'Sair'
      expect(page).to have_content 'joao@gmail.com'
    end
  end
end
