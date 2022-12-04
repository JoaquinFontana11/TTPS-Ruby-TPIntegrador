class SessionsController < ApplicationController

    def create
        @user = User.find_by(username: params[:username])
        puts "-------------------------------------"
        puts @user.password
        puts @user.username
        puts @user.authenticate(params[:password])
        puts "-------------------------------------"
        if !!@user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            puts "INGRESADO"
            redirect_to root_path

        else
            message = "Algo salio mal!. Verifique que su usuario y contraseña sean correctos"
            puts "ERROR"
            redirect_to login_path, alert: message
        end
    end

    def destroy
        reset_session
        redirect_to login_path
    end

    def home
        if helpers.logged_in?
            @user = helpers.current_user
        else
            redirect_to login_path
        end
    end
end