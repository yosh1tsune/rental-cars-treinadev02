class CarCategory < ApplicationRecord
    validates :name, :daily_rate, :car_insurance, :third_party_insurance, presence: { message: 'Você deve preencher todos os campos' }
    validates :name, uniqueness: { message: 'Nome já está em uso' }
    has_many :car_models
    has_many :cars, through: :car_models
    has_many :rentals
end
