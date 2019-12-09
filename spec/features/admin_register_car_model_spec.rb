require 'rails_helper'

feature 'Admin register car model' do
    scenario 'successfully' do
        admin = User.create(email: 'bruno@email.com', password: '123456789', role: 1)
        Manufacturer.create(name: 'Chevrolet')
        Manufacturer.create(name: 'Honda')
        CarCategory.create(name: 'A', daily_rate: 100, car_insurance: 50, third_party_insurance: 90)
        CarCategory.create(name: 'B', daily_rate: 200, car_insurance: 150, third_party_insurance: 190)

        login_as(admin)
        visit root_path
        click_on 'Modelos de carro'
        click_on 'Registrar novo modelo'

        fill_in 'Nome', with: 'Onix'
        fill_in 'Ano', with: '2020'
        fill_in 'Motorização', with: '1.0'
        fill_in 'Combustível', with: 'Flex'
        select 'Chevrolet', from: 'Fabricante'
        select 'A', from: 'Categoria'

        click_on 'Enviar'

        expect(page).to have_content('Modelo registrado com sucesso')
        expect(page).to have_content('Onix')
        expect(page).to have_content('Ano: 2020')
        expect(page).to have_content('Motor: 1.0')
        expect(page).to have_content('Combustível: Flex')
    end

    scenario 'and must fill all fields' do
        admin = User.create(email: 'bruno@email.com', password: '123456789', role: 1)
        Manufacturer.create(name: 'Honda')
        CarCategory.create(name: 'A', daily_rate: 100, car_insurance: 50, third_party_insurance: 90)
        
        login_as(admin)
        visit car_models_path
        click_on 'Registrar novo modelo'

        fill_in 'Nome', with: ''
        fill_in 'Ano', with: '2020'
        fill_in 'Motorização', with: '1.0'
        fill_in 'Combustível', with: 'Flex'
        select 'Honda', from: 'Fabricante'
        select 'A', from: 'Categoria'

        click_on 'Enviar'

        expect(page).to have_content('Você deve preencher todos os campos')
    end
end