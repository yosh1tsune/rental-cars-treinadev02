require 'rails_helper'

feature 'Admin register client' do
    scenario 'successfully' do
        visit root_path
        click_on 'Clientes'
        click_on 'Registrar novo cliente'

        fill_in 'Nome', with: 'Bruno Silva'
        fill_in 'CPF', with: '111.222.333-44'
        fill_in 'Email', with: 'bruno@email.com'
        click_on 'Enviar'

        expect(page).to have_content('Bruno Silva')
        expect(page).to have_content('111.222.333-44')
        expect(page).to have_content('bruno@email.com')
    end

    scenario 'and must fill all fields' do
        visit clients_path
        click_on 'Registrar novo cliente'

        fill_in 'Nome', with: ''
        fill_in 'CPF', with: '111.222.333-44'
        fill_in 'Email', with: 'bruno@email.com'
        click_on 'Enviar'

        expect(page).to have_content('Você deve preencher todos os campos')
    end

    scenario 'and must be unique' do
        Client.create(name: 'Bruno Silva', cpf: '111.222.333-44', email: 'bruno@email.com')
        
        visit clients_path
        click_on 'Registrar novo cliente'

        fill_in 'Nome', with: 'Bruno Reis'
        fill_in 'CPF', with: '111.222.333-44'
        fill_in 'Email', with: 'bruno2@email.com'
        click_on 'Enviar'

        expect(page).to have_content('CPF já cadastrado')
    end
end