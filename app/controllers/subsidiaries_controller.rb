class SubsidiariesController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    before_action :authorize_admin, only: [:new, :create, :edit, :update, :destroy]
    before_action :set_subsidiary, only: [:show, :edit, :update]

    def index
        @subsidiaries = Subsidiary.all
    end

    def show
    end

    def new
        @subsidiary = Subsidiary.new()
    end

    def edit
    end

    def create
        @subsidiary = Subsidiary.new(subsidiaries_params)

        if @subsidiary.save
            redirect_to @subsidiary
        else
            render :new
        end
    end

    def update
        if @subsidiary.update(subsidiaries_params)
            flash[:notice] = 'Filial atualizada com sucesso!'
            redirect_to @subsidiary
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

    def set_subsidiary
        @subsidiary = Subsidiary.find(params[:id])
    end

    def subsidiaries_params
        params.require(:subsidiary).permit(:name, :cnpj, :address)
    end
end