class Authentication::UsersController < ApplicationController
    skip_before_action :protect_page, except: :show
    before_action :authorize_user, except: :show

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
        unless params[:photo].present?
            @user.photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', @user.imageDefault)), filename: 'perfil.png', content_type: 'image/png')
          end
        if @user.save
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
        params.require(:user).permit(:name,:username,:photo,:password,:admin)
    end

    def user
        @user = User.find(params[:id])
    end

end