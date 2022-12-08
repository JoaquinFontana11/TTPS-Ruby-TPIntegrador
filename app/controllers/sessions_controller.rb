class SessionsController < ApplicationController

    def create
        @user = User.find_by(username: params[:user][:username])
        puts "-------------------------------------"
        puts @user.password
        puts @user.username
        puts @user.authenticate(params[:user][:password])
        puts "-------------------------------------"
        if !!@user && @user.authenticate(params[:user][:password])
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

    def register
        @user = User.new
        render "sessions/register"
    end

    def create_client
        message = validateUserInputs
            if !message
                @user = User.new(user_params)
                if @user.save
                    redirect_to login_path, notice: "Te has Registrado!!"
                else
                    redirect_to login_path, alert: "Algo salio mal al registrarte"
                end
            else
                redirect_to register_path, alert: message
            end
    end

    private

    def user_params
        params.require(:user).permit(:username, :password, :role)
    end

    def validateUserInputs
        if !(params.has_key?(:authenticity_token))
            return "Estas intentando ingresar por donde no deberias"
        elsif !(params.has_key?(:user) && params[:user].has_key?(:username) && params[:user].has_key?(:password) && params[:user].has_key?(:role))
            return "Te falta Ingresar algun Dato"
        elsif !(params[:user][:username] != "" && params[:user][:password] != "" && params[:user][:role] != "")
            return "Debe Completar todos los campos"
        end
        return false
    end

end