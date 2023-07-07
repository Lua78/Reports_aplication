class Authentication::UsersController < ApplicationController
    def index 
        @users = User.order(name: :asc).load_async
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

    def update
        if user.update(user_params)
            redirect_to users_path, notice: 'Usuario actualizado.'
        else
            render new:, status: :unprocessable_entity, alert: 'Error al intentar actualizar el usuario.'
        end
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to users_path,  notice:'Usuario agregado correctamente.'
        else
            render :new ,status: :unprocessable_entity, alert: 'Ha ocurrido un error.'
        end
    end

    def destroy
        if user.delete
            redirect_to users_path, notice: 'Usuario eliminado'
        else
            redirect_to user_path(user.id),status: :unprocessable_entity, alert: 'Error al intentar eliminar a este usuario.'
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