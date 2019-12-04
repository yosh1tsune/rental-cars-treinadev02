require 'rails_helper'

feature 'Admin view clients' do
    scenario 'successfully' do
        Client.create(name: 'Bruno Silva', cpf: '111.222.333-44', email: 'bruno@email.com')

        visit root_path
        click_on 'Clientes'
        click_on 'Bruno Silva'

        expect(page).to have_content('Bruno Silva')
        expect(page).to have_content('111.222.333-44')
        expect(page).to have_content('bruno@email.com')
    end
end