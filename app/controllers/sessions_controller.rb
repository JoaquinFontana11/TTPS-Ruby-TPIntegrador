class SessionsController < ApplicationController

    def create
        @user = User.find_by(username: params[:username])
        @user.password_digest= BCrypt::Password.create(@user.password_digest)

        if !!@user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            message = "Ingresasteeeeeee"
            puts "INGRESADO"
            # redirect_to user_path
            redirect_to login_path, notice: message

        else
            message = "Algo salio mal!. Verifique que su usuario y contraseña sean correctos"
            puts "ERROR"
            redirect_to login_path, notice: message
        end
    end
end