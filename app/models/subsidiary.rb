class Subsidiary < ApplicationRecord
    validates :name, :cnpj, :address, presence: { message: 'Você deve preencher todos os campos' }
    validates :name, uniqueness: { message: 'Nome já está em uso' }
    validates :cnpj, uniqueness: { message: 'CNPJ já cadastrado' }

    has_many :car
end
