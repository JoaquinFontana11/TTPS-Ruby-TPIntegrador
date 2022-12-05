class ApplicationController < ActionController::Base

    def authenticate_user!
        if !(helpers.logged_in?)
            redirect_to login_path
        end
    end

end
