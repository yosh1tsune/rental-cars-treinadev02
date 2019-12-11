require 'rails_helper'

feature 'user start rental' do
    scenario 'successfully' do
        user = User.create!(email: 'bruno@email.com', password: '12345678', role: :employee)
        client = Client.create!(name: 'Bruno Silva', cpf: '743.341.870-99', email: 'bruno@email.com')
        car_category = CarCategory.create!(name: 'A', daily_rate: '150', car_insurance: '60', third_party_insurance: '50')
        manufacturer = Manufacturer.create!(name: 'Nissan')
        car_model = CarModel.create!(name: 'Skyline', year: 2002, motorization: 4.0, fuel_type: 'Gasoline', manufacturer_id: 1, car_category_id: 1)
        subsidiary = Subsidiary.create!(name: 'Alphaville', cnpj: '11.222.333-444/55', address: 'Alameda Araguaia, 555')
        car = Car.create!(license_plate: 'ABC1234', mileage: 500, color: 'Preto', subsidiary_id: 1, car_model_id: 1)
        rental = Rental.create!(start_date: 1.day.from_now, end_date: 2.days.from_now, client: client, car_category: car_category)

        login_as(user, scope: :user)
        visit rental_path(rental)
        select "#{car_model.name} - #{car.license_plate}", from: 'Carro'
        click_on 'Iniciar Locação'

        expect(page).to have_content('Locação iniciada com sucesso')
        expect(page).not_to have_button('Iniciar Locação')
        rental.reload
        car.reload
        expect(rental).to be_in_progress
        expect(car).not_to be_available
    end
end