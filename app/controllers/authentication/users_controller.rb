class Authentication::UsersController < ApplicationController
    def index 
        @users = User.order(name: :asc).load_async
        pp @users[0]::name
        @pagy, @users = pagy_countless(@users,items: 10)
    end

    def new
        @user = User.new
    end

    def show
        user
    end

    def edit
        user
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to users_path,  notice:'Usuario agregado correctamente.'
        else
            render :new ,status: :unprocessable_entity, alert: 'Ha ocurrido un error.'
        end
    end

    private
    def  user_params
        params.require(:user).permit(:name,:username,:password,:admin)
    end

    def user
        @user = User.find(params[:id])
    end

end