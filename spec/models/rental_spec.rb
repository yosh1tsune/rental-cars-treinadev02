require 'rails_helper'

describe Rental do
    describe '.date_validators' do
        it 'successfully' do
            client = Client.new(name: 'Bruno Silva', cpf: '743.341.870-99', email: 'bruno@email.com')
            car_category = CarCategory.new(name: 'A', daily_rate: '150', car_insurance: '60', third_party_insurance: '50')
            subsidiary = Subsidiary.new(name: 'Osasco', cnpj: '11.222.333/4444-55', address: '1234')
            rental = Rental.new(start_date: '09/12/2019', end_date: '10/12/2019', client: client, car_category: car_category, subsidiary: subsidiary)

            rental.valid?

            # expect(rental.errors.empty?).to eq true
            expect(rental.errors).to be_empty
        end

        it 'start date greater than end date' do
            rental = Rental.new(start_date: 2.days.from_now, end_date: 1.day.from_now)

            rental.valid?
            
            expect(rental.errors.full_messages).to include 'End date deve ser maior que data de início'
        end

        it 'end date equal start date' do
            rental = Rental.new(start_date: 1.day.from_now, end_date: 1.day.from_now)

            rental.valid?
            
            expect(rental.errors.full_messages).to include 'End date deve ser maior que data de início'
        end

        it 'start date must exist' do
            client = Client.new(name: 'Bruno Silva', cpf: '743.341.870-99', email: 'bruno@email.com')
            car_category = CarCategory.new(name: 'A', daily_rate: '150', car_insurance: '60', third_party_insurance: '50')
            subsidiary = Subsidiary.new(name: 'Osasco', cnpj: '11.222.333/4444-55', address: '1234')
            rental = Rental.new(end_date: 3.days.from_now, client: client, car_category: car_category, subsidiary: subsidiary)

            rental.valid?

            expect(rental.errors.full_messages).to eq(["Start date deve ser preenchida"])
        end

        it 'end date must exist' do
            client = Client.new(name: 'Bruno Silva', cpf: '743.341.870-99', email: 'bruno@email.com')
            car_category = CarCategory.new(name: 'A', daily_rate: '150', car_insurance: '60', third_party_insurance: '50')
            subsidiary = Subsidiary.new(name: 'Osasco', cnpj: '11.222.333/4444-55', address: '1234')
            rental = Rental.new(start_date: 1.day.from_now, client: client, car_category: car_category, subsidiary: subsidiary)

            rental.valid?

            expect(rental.errors.full_messages).to eq(["End date deve ser preenchida"])
        end
    end

    describe '.cars_available' do
        it 'should be false if subsidiary has no cars' do
            client = Client.create!(name: 'Bruno Silva', cpf: '743.341.870-99', email: 'bruno@email.com')
            car_category = CarCategory.create!(name: 'A', daily_rate: '150', car_insurance: '60', third_party_insurance: '50')
            subsidiary = Subsidiary.create!(name: 'Osasco', cnpj: '11.222.333/4444-55', address: '1234')
            manufacturer = Manufacturer.create!(name: 'Honda')
            car_model = CarModel.create!(name: 'Civic', year: 2018, manufacturer: manufacturer, fuel_type: 'Flex', motorization: '2.0', car_category: car_category )
            rental = Rental.create!(start_date: '09/12/2019', end_date: '10/12/2019', client: client, car_category: car_category, subsidiary: subsidiary)
            
            result = rental.cars_available?

            expect(result).to be false
        end

        it 'should be true if subsidiary has cars' do
            client = Client.create!(name: 'Bruno Silva', cpf: '743.341.870-99', email: 'bruno@email.com')
            car_category = CarCategory.create!(name: 'A', daily_rate: '150', car_insurance: '60', third_party_insurance: '50')
            subsidiary = Subsidiary.create!(name: 'Osasco', cnpj: '11.222.333/4444-55', address: '1234')
            manufacturer = Manufacturer.create!(name: 'Honda')
            car_model = CarModel.create!(name: 'Civic', year: 2018, manufacturer: manufacturer, fuel_type: 'Flex', motorization: '2.0', car_category: car_category )
            car = Car.create!(license_plate: 'ABC1234', mileage: 0, color: 'Preto', car_model: car_model, subsidiary: subsidiary)
            rental = Rental.create!(start_date: '09/12/2019', end_date: '10/12/2019', client: client, car_category: car_category, subsidiary: subsidiary)
            
            result = rental.cars_available?

            expect(result).to be true
        end

        it 'should be true if subsidiary has cars from rental category' do
            client = Client.create!(name: 'Bruno Silva', cpf: '743.341.870-99', email: 'bruno@email.com')
            car_category = CarCategory.create!(name: 'A', daily_rate: '150', car_insurance: '60', third_party_insurance: '50')
            other_car_category = CarCategory.create!(name: 'B', daily_rate: '150', car_insurance: '60', third_party_insurance: '50')
            subsidiary = Subsidiary.create!(name: 'Osasco', cnpj: '11.222.333/4444-55', address: '1234')
            manufacturer = Manufacturer.create!(name: 'Honda')
            car_model = CarModel.create!(name: 'Civic', year: 2018, manufacturer: manufacturer, fuel_type: 'Flex', motorization: '2.0', car_category: car_category )
            car = Car.create!(license_plate: 'ABC1234', mileage: 0, color: 'Preto', car_model: car_model, subsidiary: subsidiary)
            rental = Rental.create!(start_date: '09/12/2019', end_date: '10/12/2019', client: client, car_category: other_car_category, subsidiary: subsidiary)
            
            result = rental.cars_available?

            expect(result).to be true
        end

        it 'should be false if subsidiary has rentals scheduled' do
            client = Client.create!(name: 'Bruno Silva', cpf: '743.341.870-99', email: 'bruno@email.com')
            car_category = CarCategory.create!(name: 'A', daily_rate: '150', car_insurance: '60', third_party_insurance: '50')
            other_car_category = CarCategory.create!(name: 'B', daily_rate: '150', car_insurance: '60', third_party_insurance: '50')
            subsidiary = Subsidiary.create!(name: 'Osasco', cnpj: '11.222.333/4444-55', address: '1234')
            manufacturer = Manufacturer.create!(name: 'Honda')
            car_model = CarModel.create!(name: 'Civic', year: 2018, manufacturer: manufacturer, fuel_type: 'Flex', motorization: '2.0', car_category: car_category )
            car = Car.create!(license_plate: 'ABC1234', mileage: 0, color: 'Preto', car_model: car_model, subsidiary: subsidiary)
            scheduled_rental = Rental.create!(start_date: 1.day.from_now, end_date: 4.days.from_now, client: client, car_category: other_car_category, subsidiary: subsidiary)
            new_rental = Rental.create!(start_date: 2.days.from_now, end_date: 3.days.from_now, client: client, car_category: other_car_category, subsidiary: subsidiary)
            
            result = new_rental.cars_available?

            expect(result).to be false
        end
    end
end
