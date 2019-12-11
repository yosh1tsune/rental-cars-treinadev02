require 'rails_helper'

feature 'admin register car' do
    scenario 'successfully' do
        admin = User.create(email: 'bruno@email.com', password: '123456789', role: 1)
        Manufacturer.create(name: 'Nissan')
        CarCategory.create(name: 'C', daily_rate: 300, car_insurance: 100, third_party_insurance: 80)
        CarModel.create(name: 'Skyline', year: 2002, motorization: 4.0, fuel_type: 'Gasoline', manufacturer_id: 1, car_category_id: 1)
        Subsidiary.create(name: 'Alphaville', cnpj: '11.222.333-444/55', address: 'Alameda Araguaia, 555')

        login_as(admin)
        visit root_path

        click_on 'Carros'
        click_on 'Cadastrar novo carro'

        fill_in 'Placa', with: 'ABC1234'
        fill_in 'Quilometragem', with: 500
        fill_in 'Cor', with: 'Preto'
        select 'Alphaville', from: 'Filial'
        select 'Skyline', from: 'Modelo'
        click_on 'Enviar'

        expect(page).to have_content('ABC1234')
        expect(page).to have_content('500')
        expect(page).to have_content('Preto')
        expect(page).to have_content('Skyline')
        expect(page).to have_content('Alphaville')
    end

    scenario 'and must fill all fields' do
        admin = User.create(email: 'bruno@email.com', password: '123456789', role: 1)
        Manufacturer.create(name: 'Nissan')
        CarCategory.create(name: 'C', daily_rate: 300, car_insurance: 100, third_party_insurance: 80)
        CarModel.create(name: 'Skyline', year: 2002, motorization: 4.0, fuel_type: 'Gasoline', manufacturer_id: 1, car_category_id: 1)
        Subsidiary.create(name: 'Alphaville', cnpj: '11.222.333-444/55', address: 'Alameda Araguaia, 555')

        login_as(admin)
        visit cars_path
        click_on 'Cadastrar novo carro'

        fill_in 'Placa', with: ''
        fill_in 'Quilometragem', with: ''
        fill_in 'Cor', with: 'Preto'
        select 'Alphaville', from: 'Filial'
        select 'Skyline', from: 'Modelo'
        click_on 'Enviar'

        expect(page).to have_content('Você deve preencher todos os campos')
    end

    scenario 'and must be unique' do
        admin = User.create(email: 'bruno@email.com', password: '123456789', role: 1)
        Manufacturer.create(name: 'Nissan')
        CarCategory.create(name: 'C', daily_rate: 300, car_insurance: 100, third_party_insurance: 80)
        CarModel.create(name: 'Skyline', year: 2002, motorization: 4.0, fuel_type: 'Gasoline', manufacturer_id: 1, car_category_id: 1)
        Subsidiary.create(name: 'Alphaville', cnpj: '11.222.333-444/55', address: 'Alameda Araguaia, 555')
        Car.create!(license_plate: 'ABC1234', mileage: 500, color: 'Preto', subsidiary_id: 1, car_model_id: 1)

        login_as(admin)
        visit cars_path
        click_on 'Cadastrar novo carro'

        fill_in 'Placa', with: 'ABC1234'
        fill_in 'Quilometragem', with: 300
        fill_in 'Cor', with: 'Azul'
        select 'Alphaville', from: 'Filial'
        select 'Skyline', from: 'Modelo'
        click_on 'Enviar'

        expect(page).to have_content('Placa já cadastrada em outro veículo')
    end

    scenario 'and must be logged in' do
        visit root_path
        click_on 'Carros'
  
        expect(page).not_to have_link('Cadastrar novo carro')
    end
  
    scenario 'and redirect to login page if not' do
        visit new_car_path
    
        expect(current_path).to eq new_user_session_path
    end
end