class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path
        else
            render :new
        end
    end
    
    def show
        @user = User.find(params[:id])
    end

    def updatePassword

        @user = User.find(params[:id])
        puts " ------------- PARAMETROS GET ------------- "
        puts params
        puts " -------------------------------------- "
        render "updatePassword"
    end

    def changePasword
        puts " ------------- PARAMETROS POST ------------- "
        puts params
        puts " -------------------------------------- "
        @user = User.find(params[:id])
        message = ""
        if !(params.has_key?(:authenticity_token))
            message = "Estas intentando ingresar por donde no deberias..."
        elsif !(params.has_key?(:id) && params.has_key?(:password) && params.has_key?(:new_password) && params.has_key?(:confirm_password))
            message = "Te falta Ingresar algun Dato"
        elsif (params[:password] == "" && params[:new_password] == "" && params[:confirm_password] == "")
            message = "Debe completar todos los campos"
        elsif !(@user.authenticate(params[:password]))
            message = "La contrasela actual es Incorrecta"
        elsif (params[:new_password] != params[:confirm_password])
            message = "Las Contraseñas no Coinciden"
        elsif (params[:new_password] == params[:password])
            message = "La nueva contraseña no puede ser igual a la Anterior"
        end
        puts message
        if message == ""
            # puts " -------------------------------------- "
            # puts @user.update_attribute(:password, params[:new_password])
            # puts " -------------------------------------- "
            if @user.update_attribute(:password, params[:new_password])
                message = "La contraseña se modifico con Exito"
                puts "Modificadoo"
            else
                message = "Ocurrio un error al modificar la contraseña"
                puts "Errorrrr"
            end
            puts "FUNCIONAaaaAAAAAAAAAAAAAAAAAAAAAA"
            redirect_to update_password_path(@user), notice: message
        else
            redirect_to update_password_path(@user), alert: message
        end

    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end