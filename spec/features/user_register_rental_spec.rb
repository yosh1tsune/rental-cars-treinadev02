require 'rails_helper'

feature 'user register a rental' do
    scenario 'successfully' do
        Client.create(name: 'Bruno Silva', cpf: '111.222.333-44', email: 'bruno@email.com')
        CarCategory.create(name: 'A', daily_rate: '150', car_insurance: '60', third_party_insurance: '50')

        visit root_path
        click_on 'Locações'
        click_on 'Nova locação'

        fill_in 'Data de início', with: '2019-12-06'
        fill_in 'Data de término', with: '2019-12-13'
        select 'Bruno Silva', from: 'Cliente'
        select 'A', from: 'Categoria'
        click_on 'Enviar'

        expect(page).to have_content('Data de início: 2019-12-06')
        expect(page).to have_content('Data de término: 2019-12-13')
        expect(page).to have_content('Cliente: Bruno Silva')
        expect(page).to have_content('Categoria: A')
    end

    # scenario '' do
        
    # end

    # scenario '' do
        
    # end
end