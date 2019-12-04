class ManufacturersController < ApplicationController
    def index
        @manufacturers = Manufacturer.all
        @car_models = CarModel.all
    end

    def show
        @manufacturer = Manufacturer.find(params[:id])
    end

    def new
        @manufacturer = Manufacturer.new
    end

    def edit
        @manufacturer = Manufacturer.find(params[:id])    
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
        @manufacturer = Manufacturer.find(params[:id])
        if @manufacturer.update(manufacturer_params)
            flash[:notice] = 'Fabricante atualizado com sucesso!'
            redirect_to @manufacturer
        else
            render :edit
        end
    end

    private

    def manufacturer_params
        params.require(:manufacturer).permit(:name)
    end
end