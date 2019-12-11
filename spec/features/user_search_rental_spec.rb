require 'rails_helper'

feature 'User search rental' do
    scenario 'successfully' do
        user = User.create(email: 'bruno@email.com', password: '1234578', role: :employee)
        client = Client.create(name: 'Bruno Silva', cpf: '743.341.870-99', email: 'bruno@email.com')
        car_category = CarCategory.create(name: 'A', daily_rate: '150', car_insurance: '60', third_party_insurance: '50')
        rental = Rental.create(start_date: 1.day.from_now, end_date: 2.days.from_now, client: client, car_category: car_category, reservation_code: 'ABC123')
        another_rental = Rental.create(start_date: 1.day.from_now, end_date: 2.days.from_now, client: client, car_category: car_category, reservation_code: 'DEF456')

        login_as(user, scope: :user)
        visit root_path
        click_on 'Locações'
        fill_in 'Código', with: rental.reservation_code
        click_on 'Buscar'

        expect(page).to have_content(rental.reservation_code)
        expect(page).not_to have_content(another_rental.reservation_code)
    end

    scenario 'and partial search with more than one matches' do
        user = User.create(email: 'bruno@email.com', password: '1234578', role: :employee)
        client = Client.create(name: 'Bruno Silva', cpf: '743.341.870-99', email: 'bruno@email.com')
        car_category = CarCategory.create(name: 'A', daily_rate: '150', car_insurance: '60', third_party_insurance: '50')
        rental = Rental.create(start_date: 1.day.from_now, end_date: 2.days.from_now, client: client, car_category: car_category, reservation_code: 'ABC123')
        another_rental = Rental.create(start_date: 1.day.from_now, end_date: 2.days.from_now, client: client, car_category: car_category, reservation_code: 'DEF456')
        third_rental = Rental.create(start_date: 1.day.from_now, end_date: 2.days.from_now, client: client, car_category: car_category, reservation_code: 'ABZ980')

        login_as(user, scope: :user)
        visit root_path
        click_on 'Locações'
        fill_in 'Código', with: 'AB'
        click_on 'Buscar'

        expect(page).to have_content(rental.reservation_code)
        expect(page).to have_content(third_rental.reservation_code)
        expect(page).not_to have_content(another_rental.reservation_code)
    end

    scenario 'or nothing' do
        user = User.create(email: 'bruno@email.com', password: '1234578', role: :employee)
        client = Client.create(name: 'Bruno Silva', cpf: '743.341.870-99', email: 'bruno@email.com')
        car_category = CarCategory.create(name: 'A', daily_rate: '150', car_insurance: '60', third_party_insurance: '50')
        rental = Rental.create(start_date: 1.day.from_now, end_date: 2.days.from_now, client: client, car_category: car_category, reservation_code: 'FGH123')
        another_rental = Rental.create(start_date: 1.day.from_now, end_date: 2.days.from_now, client: client, car_category: car_category, reservation_code: 'DEF456')

        login_as(user, scope: :user)
        visit root_path
        click_on 'Locações'
        fill_in 'Código', with: 'ABC'
        click_on 'Buscar'

        expect(page).not_to have_content(rental.reservation_code)
        expect(page).not_to have_content(another_rental.reservation_code)
    end
end