class Rental < ApplicationRecord
  validates :start_date, :end_date, presence: { message: 'deve ser preenchida'}
  validate :date_validators
  # validate :cars_available, on: :create
  has_one :car_rental
  has_one :car, through: :car_rental
  belongs_to :client
  belongs_to :car_category
  enum status: {scheduled: 0, in_progress: 5}

  def date_validators
    return unless start_date.present? && end_date.present?

    if ((end_date < start_date) || (end_date == start_date))
      errors.add(:end_date, 'deve ser maior que data de início')
    end
  end
end
