module Authentication
    extend ActiveSupport::Concern
    included do
        before_action :set_current_user
        before_action :protect_page

        private 
        def set_current_user
            Current.user =  User.find_by(id: session[:user_id]) if session[:user_id]
        end
    
        def protect_page
            redirect_to new_session_path ,alert: 'Debes iniciar sesion.' unless Current.user
        end

    end

end