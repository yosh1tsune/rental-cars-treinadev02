require 'rails_helper'

feature 'user register a rental' do
    scenario 'successfully' do
        user = User.create(email: 'bruno@email.com', password: '12345678', role: :employee)
        Client.create(name: 'Bruno Silva', cpf: '743.341.870-99', email: 'bruno@email.com')
        CarCategory.create(name: 'A', daily_rate: '150', car_insurance: '60', third_party_insurance: '50')

        login_as(user, scope: :user)
        visit root_path
        click_on 'Locações'
        click_on 'Nova locação'

        fill_in 'Data de início', with: '2019-12-06'
        fill_in 'Data de término', with: '2019-12-13'
        select 'Bruno Silva - 743.341.870-99', from: 'Cliente'
        select 'A', from: 'Categoria'
        click_on 'Enviar'

        expect(page).to have_content('Locação registrada com sucesso')
        expect(page).to have_content('Data de início: 06/12/2019')
        expect(page).to have_content('Data de término: 13/12/2019')
        expect(page).to have_content('Cliente: Bruno Silva')
        expect(page).to have_content('Categoria: A')
    end

    # scenario 'and must fill all fields' do
        
    # end

    # scenario 'and start date must be less than end date' do
        
    # end
end