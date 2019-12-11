class Car < ApplicationRecord
  validates :license_plate, :color, :car_model_id, :mileage, :subsidiary_id, presence: { message: 'Você deve preencher todos os campos' }
  validates :license_plate, uniqueness: { message: 'Placa já cadastrada em outro veículo' }
  validates :mileage, numericality: { greater_than_or_equal_to: 0 }
  has_many :car_rentals
  has_many :rentals, through: :car_rentals
  belongs_to :car_model
  belongs_to :subsidiary
  has_one :car_category, through: :car_model
  enum status: {available: 0, unavailable: 5}

  def description
    "#{car_model.name} - #{license_plate}"
  end

  def price#passar para o car category
    car_category.daily_rate + car_category.car_insurance + car_category.third_party_insurance
  end
end
