class CarModelsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    before_action :authorize_admin, only: [:new, :create, :edit, :update, :destroy]

    def index
        @car_models = CarModel.all
    end

    def show
        @car_model = CarModel.find(params[:id])
    end

    def new
        @car_model = CarModel.new
        @manufacturers = Manufacturer.all
        @car_categories = CarCategory.all
    end

    def create
        @car_model = CarModel.new(car_model_params)
        if @car_model.save
            flash[:notice] = 'Modelo registrado com sucesso'
            redirect_to @car_model
        else
            @manufacturers = Manufacturer.all
            @car_categories = CarCategory.all
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

    def car_model_params
        params.require(:car_model).permit(:name, :year, :motorization, :fuel_type, :car_category_id, :manufacturer_id)
    end
end