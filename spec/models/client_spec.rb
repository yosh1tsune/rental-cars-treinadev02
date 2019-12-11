require 'rails_helper'

describe Client do
    describe '.description' do
        it 'must return name with document' do
            client = Client.new(name: 'Bruno', email: 'bruno@email.com', cpf: '743.341.870-99')

            expect(client.description).to eq 'Bruno - 743.341.870-99'
        end
    end
end
