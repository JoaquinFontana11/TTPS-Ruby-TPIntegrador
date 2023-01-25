class SessionsController < ApplicationController

    def create
        @user = User.find_by(username: params[:user][:username])
        if !!@user && @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            redirect_to root_path

        else
            message = "Algo salio mal!. Verifique que su usuario y contraseña sean correctos"
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

    def register
        @user = User.new
        render "sessions/register"
    end

    def create_client

                @user = User.new(user_params)
                if @user.save
                    redirect_to login_path, notice: "Te has Registrado!!"
                else
                    redirect_to login_path, alert: "Algo salio mal al registrarte"
                end

    end

    private

    def user_params
        params.require(:user).permit(:username, :password, :role)
    end


end