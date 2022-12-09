class ApplicationController < ActionController::Base

    def authenticate_user!
        if !(helpers.logged_in?)
            redirect_to login_path
        end
    end

    def current_ability
        @current_ability ||= Ability.new(helpers.current_user)
    end

    rescue_from CanCan::AccessDenied do |exception|
        flash[:alert] = "No tenes permisos para acceder a esa funcionalidad"
        redirect_to root_path
    end

end
