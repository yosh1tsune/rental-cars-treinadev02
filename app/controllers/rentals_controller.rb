class RentalsController < ApplicationController
    def index
        @rentals = Rental.all
    end

    def show
        @rental = Rental.find(params[:id])
    end

    def new
        @rental = Rental.new
        @clients = Client.all
        @car_categories = CarCategory.all
    end

    def create
        @rental = Rental.create(rental_params)

        redirect_to @rental
    end

    private

    def rental_params
        params.require(:rental).permit(:start_date, :end_date, :client_id, :car_category_id)
    end
end