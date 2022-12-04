class UsersController < ApplicationController

    def new
        @user = User.new user_params
        puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    end

    def create
        @branch_office = BranchOffice.find(params[:user][:branch_office])
        if !(@branch_office)
            redirect_to new_user_path, alert: "No existe la Sucursal Seleccionada"
        end
        params[:user][:branch_office] = @branch_office
        @user = User.new(user_params)

        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path
        else
            render :new
        end
    end

    def home
        if helpers.logged_in?
            @users = User.all
          else
            redirect_to login_path
        end
    end
    
    def show
        @user = User.find(params[:id])
    end

    def updatePassword
        @user = User.find(params[:id])
        render "updatePassword"
    end

    def changePasword
        @user = User.find(params[:id])
        message = validatePasswordInputs
        puts "----------------------------------"
        puts message
        puts "----------------------------------"
        if !message
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
        params.fetch(:user ,  {}).permit(:username, :password, :role, :branch_office)
    end

    def validatePasswordInputs
        @user = User.find(params[:id])
        if !(params.has_key?(:authenticity_token))
            return "Estas intentando ingresar por donde no deberias..."
        elsif !(params.has_key?(:id) && params.has_key?(:password) && params.has_key?(:new_password) && params.has_key?(:confirm_password))
            return "Te falta Ingresar algun Dato"
        elsif !(params[:password] != "" && params[:new_password] != "" && params[:confirm_password] != "")
            return "Debe completar todos los campos"
        elsif !(@user.authenticate(params[:password]))
            return "La contrasela actual es Incorrecta"
        elsif (params[:new_password] != params[:confirm_password])
            return "Las Contraseñas no Coinciden"
        elsif (params[:new_password] == params[:password])
            return "La nueva contraseña no puede ser igual a la Anterior"
        end
        return false
    end
end