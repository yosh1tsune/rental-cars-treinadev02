class Car < ApplicationRecord
  validates :license_plate, :color, :car_model_id, :mileage, :subsidiary_id, presence: { message: 'Você deve preencher todos os campos' }
  validates :license_plate, uniqueness: { message: 'Placa já cadastrada em outro veículo' }
  belongs_to :car_model
  belongs_to :subsidiary
end
