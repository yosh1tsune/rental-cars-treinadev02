class ManufacturersController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    before_action :authorize_admin, only: [:new, :create, :edit, :update, :destroy]
    before_action :set_manufacturer, only: [:show, :edit, :update]

    def index
        @manufacturers = Manufacturer.all
        @car_models = CarModel.all
    end

    def show
    end

    def new
        @manufacturer = Manufacturer.new
    end

    def edit 
    end

    def create
        # byebug # Debug
        @manufacturer = Manufacturer.new(manufacturer_params)

        if @manufacturer.save
            redirect_to @manufacturer
        else
            render :new
        end
    end

    def update
        if @manufacturer.update(manufacturer_params)
            flash[:notice] = 'Fabricante atualizado com sucesso!'
            redirect_to @manufacturer
        else
            render :edit
        end
    end

    private

    def authorize_admin
        unless current_user.admin?
            flash[:notice] = 'Você não tem essa autorização'
            redirect_to root_path
        end
    end

    def set_manufacturer
        @manufacturer = Manufacturer.find(params[:id])
    end

    def manufacturer_params
        params.require(:manufacturer).permit(:name)
    end
end