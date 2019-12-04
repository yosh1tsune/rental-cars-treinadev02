class Client < ApplicationRecord
    validates :name, :cpf, :email, presence: { message: 'Você deve preencher todos os campos' }
    validates :cpf, uniqueness: { message: 'CPF já cadastrado' }
end
