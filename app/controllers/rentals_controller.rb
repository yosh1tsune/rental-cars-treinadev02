class RentalsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    
    def index
        @rentals = Rental.all
    end

    def show
        @rental = Rental.find(params[:id])
        @cars = @rental.car_category.cars
        # @cars = Car.joins(:car_model).where(car_models: {car_category: @rental.car_category})
    end

    def new
        @rental = Rental.new
        @clients = Client.all
        @car_categories = CarCategory.all
    end

    def create
        @rental = Rental.new(rental_params)

        if @rental.save
            flash[:notice] = 'Locação registrada com sucesso'
            redirect_to @rental
        else
            @clients = Client.all
            @car_categories = CarCategory.all
            render :new
        end
    end

    def search
        @rentals = Rental.where('reservation_code like ?', "%#{params[:q]}%")

        render :index
    end

    def start
        @rental = Rental.find(params[:id])
        @rental.in_progress!

        @car = Car.find(params[:rental][:car_id])
        @car.unavailable!

        @rental.create_car_rental(car: @car, price: @car.price)

        flash[:notice] = 'Locação iniciada com sucesso'
        redirect_to @rental
    end

    private

    def rental_params
        params.require(:rental).permit(:start_date, :end_date, :client_id, :car_category_id)
    end
end