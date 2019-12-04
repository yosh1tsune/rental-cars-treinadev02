require 'rails_helper'

feature 'Admin register subsidiary' do
    scenario 'successfully' do
        visit root_path
        click_on 'Filiais'
        click_on 'Registrar nova filial'

        fill_in 'Nome', with: 'Osasco'
        fill_in 'CNPJ', with: '11.222.333/4444-00'
        fill_in 'Endereço', with: 'Avenida dos Autonomistas, 9999'
        click_on 'Enviar'

        expect(page).to have_content('Osasco')
        expect(page).to have_content('11.222.333/4444-00')
        expect(page).to have_content('Avenida dos Autonomistas, 9999')
    end

    scenario 'and must fill all fields' do
        visit subsidiaries_path
        click_on 'Registrar nova filial'

        fill_in 'Nome', with: ''
        fill_in 'CNPJ', with: '11.222.333/4444-00'
        fill_in 'Endereço', with: 'Avenida dos Autonomistas, 9999'
        click_on 'Enviar'

        expect(page).to have_content('Você deve preencher todos os campos')
    end

    scenario 'and must be unique' do
        Subsidiary.create(name: 'Osasco', cnpj: '11.222.333/4444-00', address: 'Avenida dos Autonomistas, 9999')
        
        visit subsidiaries_path
        click_on 'Registrar nova filial'

        fill_in 'Nome', with: 'Osasco'
        fill_in 'CNPJ', with: '11.222.333/4444-00'
        fill_in 'Endereço', with: 'Avenida dos Autonomistas, 9999'
        click_on 'Enviar'
        
        expect(page).to have_content('Nome já está em uso')
    end
end