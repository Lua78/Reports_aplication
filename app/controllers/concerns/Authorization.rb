module Authorization
    extend ActiveSupport::Concern
    included do
        class NotAuthorizeError < StandardError; end
        rescue_from NotAuthorizeError do
            redirect_to reports_path,  alert: 'No puedes acceder a esta pagina..' 
        end

        private 
        def authorize(report)
            comp = report.user_id == Current.user::id || Current.user.admin==true
            raise NotAuthorizeError unless comp
        end
    
        def authorize_user
            raise NotAuthorizeError unless Current.user::admin
        end
    end

end