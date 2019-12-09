class CarsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    before_action :authorize_admin, only: [:new, :create, :edit, :update, :destroy]

    def index
        @cars = Car.all
    end

    def show
        @car = Car.find(params[:id])
    end

    def new
        @car = Car.new
        @subsidiaries = Subsidiary.all
        @car_models = CarModel.all
    end

    def create
        @car = Car.new(car_params)

        if @car.save
            flash[:notice] = 'Carro cadastrado com sucesso!'
            redirect_to @car
        else
            @subsidiaries = Subsidiary.all
            @car_models = CarModel.all
            render :new
        end
    end

    private

    def authorize_admin
        unless current_user.admin?
            flash[:notice] = 'Você não tem essa autorização'
            redirect_to root_path
        end
    end

    def car_params
        params.require(:car).permit(:license_plate, :color, :mileage, :car_model_id, :subsidiary_id)
    end
end