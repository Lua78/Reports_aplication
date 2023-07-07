class Authentication::SessionsController < ApplicationController
    skip_before_action :protect_page
    def new

    end
    
    def  create
        @user = User.find_by("username = :login", {login: params[:username]})
        if @user&.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to reports_path, notice: 'Bienvenido '+@user.name
        else
            redirect_to new_session_path, alert: 'Usuario o contraseña incorrectos.'
        end
    end

    def destroy
        session.delete(:user_id)
        redirect_to new_session_path
    end
end