require 'rails_helper'

describe Rental do
    describe '.date_validators' do
        it 'successfully' do
            client = Client.new(name: 'Bruno Silva', cpf: '743.341.870-99', email: 'bruno@email.com')
            car_category = CarCategory.new(name: 'A', daily_rate: '150', car_insurance: '60', third_party_insurance: '50')
            rental = Rental.new(start_date: '09/12/2019', end_date: '10/12/2019', client: client, car_category: car_category)

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
            rental = Rental.new(end_date: 3.days.from_now, client: client, car_category: car_category)

            rental.valid?

            expect(rental.errors.full_messages).to eq(["Start date deve ser preenchida"])
        end

        it 'end date must exist' do
            client = Client.new(name: 'Bruno Silva', cpf: '743.341.870-99', email: 'bruno@email.com')
            car_category = CarCategory.new(name: 'A', daily_rate: '150', car_insurance: '60', third_party_insurance: '50')
            rental = Rental.new(start_date: 1.day.from_now, client: client, car_category: car_category)

            rental.valid?

            expect(rental.errors.full_messages).to eq(["End date deve ser preenchida"])
            
        end
    end
end
