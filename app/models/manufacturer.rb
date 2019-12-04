class Manufacturer < ApplicationRecord
    validates :name, presence: { message: 'Você deve preencher todos os campos' }
    validates :name, uniqueness: { message: 'Nome já está em uso' }
end
