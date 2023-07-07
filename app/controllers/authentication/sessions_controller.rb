class Authentication::SessionsController < ApplicationController
    def new

    end
    
    def  create
        @user = User.find_by("username = :login", {login: params[:username]})
        if @user&.authenticate(params[:password])
            redirect_to reports_path, notice: 'Bienvenido '+@user.name
        else
            redirect_to new_session_path, alert: 'Usuario o contraseña incorrectos.'
        end
    end
end