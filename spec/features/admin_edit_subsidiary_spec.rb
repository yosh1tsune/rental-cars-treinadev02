require 'rails_helper'

feature 'Admin edits subsidiary' do
    scenario 'successfully' do
        Subsidiary.create(name: 'Osasco', cnpj: '11.222.333/4444-00', address: 'Avenida dos Autonomistas, 9999')        

        visit root_path
        click_on 'Filiais'
        click_on 'Osasco'
        click_on 'Editar'

        fill_in 'Nome', with: 'Caparicuiba'
        fill_in 'CNPJ', with: '11.222.333/4444-00'
        fill_in 'Endereço', with: 'Avenida dos Autonomistas, 9999'
        click_on 'Enviar'

        expect(page).to have_content('Caparicuiba')
        expect(page).to have_content('11.222.333/4444-00')
        expect(page).to have_content('Avenida dos Autonomistas, 9999')
        expect(page).to have_content('Filial atualizada com sucesso!')
    end

    scenario 'and must fill all fields' do
        Subsidiary.create(name: 'Osasco', cnpj: '11.222.333/4444-00', address: 'Avenida dos Autonomistas, 9999')

        visit subsidiaries_path
        click_on 'Osasco'
        click_on 'Editar'

        fill_in 'Nome', with: ''
        fill_in 'CNPJ', with: '11.222.333/4444-00'
        fill_in 'Endereço', with: 'Avenida dos Autonomistas, 9999'
        click_on 'Enviar'

        expect(page).to have_content('Você deve preencher todos os campos')
    end

    scenario 'and must be unique' do
        Subsidiary.create(name: 'Osasco', cnpj: '11.222.333/4444-00', address: 'Avenida dos Autonomistas, 9999')
        Subsidiary.create(name: 'Carapicuiba', cnpj: '11.222.333/4444-99', address: 'Avenida dos Autonomistas, 2222')
        
        visit subsidiaries_path
        click_on 'Carapicuiba'
        click_on 'Editar'

        fill_in 'Nome', with: 'Osasco'
        fill_in 'CNPJ', with: '11.222.333/4444-00'
        fill_in 'Endereço', with: 'Avenida dos Autonomistas, 9999'
        click_on 'Enviar'
        
        expect(page).to have_content('Nome já está em uso')
    end
end