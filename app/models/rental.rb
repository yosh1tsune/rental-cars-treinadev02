class Rental < ApplicationRecord
  validates :start_date, :end_date, presence: { message: 'deve ser preenchida'}
  validate :date_validators
  # validate :cars_available, on: :create
  has_one :car_rental
  has_one :car, through: :car_rental
  belongs_to :client
  belongs_to :car_category
  belongs_to :subsidiary
  enum status: {scheduled: 0, in_progress: 5}

  def date_validators
    return unless start_date.present? && end_date.present?

    if ((end_date < start_date) || (end_date == start_date))
      errors.add(:end_date, 'deve ser maior que data de início')
    end
  end

  def cars_available?
    car_models = CarModel.where(car_category: car_category)
    total_cars = Car.where(car_model: car_models).count
    
    total_rentals = Rental.where(car_category: car_category, subsidiary: subsidiary).where('start_date < ? AND end_date > ?', start_date, start_date).count

    (total_cars - total_rentals) > 0
  end
end
