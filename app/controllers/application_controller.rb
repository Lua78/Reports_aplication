class ApplicationController < ActionController::Base
    include Pagy::Backend

    before_action :set_current_user
    before_action :protect_page

    private
    def set_current_user
        Current.user =  User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def protect_page
        redirect_to new_session_path ,alert: 'Debe iniciar sesion.' unless Current.user
    end
end
