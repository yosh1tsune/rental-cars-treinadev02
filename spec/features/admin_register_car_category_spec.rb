require 'rails_helper'

feature 'Admin register car category' do
    scenario 'successfully' do
        admin = User.create(email: 'bruno@email.com', password: '12345678', role: 1)
        
        login_as(admin)
        visit root_path
        click_on 'Categorias de veículos'
        click_on 'Registrar nova categoria'

        fill_in 'Nome', with: 'Sedan'
        fill_in 'Diária', with: '120.99'
        fill_in 'Seguro', with: '40'
        fill_in 'Seguro contra terceiros', with: '50'
        click_on 'Enviar'

        expect(page).to have_content('Sedan')
        expect(page).to have_content('120.99')
        expect(page).to have_content('40')
        expect(page).to have_content('50')
    end

    scenario 'and must fill all fields' do
        admin = User.create(email: 'bruno@email.com', password: '12345678', role: 1)
        
        login_as(admin)
        visit car_categories_path
        click_on 'Registrar nova categoria'

        fill_in 'Nome', with: ''
        fill_in 'Diária', with: '120.99'
        fill_in 'Seguro', with: '40'
        fill_in 'Seguro contra terceiros', with: '50'
        click_on 'Enviar'

        expect(page).to have_content('Você deve preencher todos os campos')
    end

    scenario 'and must be unique' do
        CarCategory.create(name: 'SUV', daily_rate: '120', car_insurance: '60', third_party_insurance: '50')
        admin = User.create(email: 'bruno@email.com', password: '12345678', role: 1)
        
        login_as(admin)        
        visit car_categories_path
        click_on 'Registrar nova categoria'

        fill_in 'Nome', with: 'SUV'
        fill_in 'Diária', with: '120.99'
        fill_in 'Seguro', with: '40'
        fill_in 'Seguro contra terceiros', with: '50'
        click_on 'Enviar'

        expect(page).to have_content('Nome já está em uso')
    end
end