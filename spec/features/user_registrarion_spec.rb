require 'rails_helper'

feature 'User sign up' do
    scenario 'successfully' do
        visit root_path
        click_on 'Entrar'
        click_on 'Registrar-se'

        fill_in 'Email', with: 'bruno@email.com'
        fill_in 'Senha', with: '12345678'
        fill_in 'Confirme sua senha', with: '12345678'
        click_on 'Registrar-se'

        expect(page).to have_content('Welcome! You have signed up successfully')
    end
end