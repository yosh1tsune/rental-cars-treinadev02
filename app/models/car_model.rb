class CarModel < ApplicationRecord
  validates :name, :year, :manufacturer_id, :fuel_type, :motorization, :car_category_id, presence: { message: 'Você deve preencher todos os campos' }
  belongs_to :manufacturer
  belongs_to :car_category
  has_many :cars
end
