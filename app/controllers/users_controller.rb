class UsersController < ApplicationController

    before_action :authenticate_user!

    def home
        @users = User.all
    end
    
    def show
        @user = User.find(params[:id])
    end

    def new
        @user = User.new user_params
        @branch_offices = BranchOffice.all
    end

    def create
            message = validateUserInputs
            if !message
                redirect_to new_user_path, alert: message 
                @user = User.new(user_params)
                if(params[:user][:role] == "staff")
                    if !(BranchOffice.find(params[:branch_office]))
                        redirect_to new_user_path, alert: "No existe la Sucursal Seleccionada"
                    end
                    @branch_office = BranchOffice.find(params[:branch_office])
                    @user.branch_office = @branch_office
                end
                if @user.save
                    redirect_to users_home_path, notice: "El usuario se creo correctamente"
                else
                    redirect_to new_user_path, alert: "Algo salio mal al crear el usuario"
                end
            else
                redirect_to new_user_path, alert: message
            end
    end

    def edit
        @old_user = User.find(params[:id])
        render "users/edit"
    end

    def update
            message = validateUserInputs
            if !message

                if !(User.find(params[:id]))
                    redirect_to user_edit_path, alert: "No se econtro el usuario"
                end

                @user = User.find(params[:id])
                if(params[:user][:role] == "staff")
                    if !(BranchOffice.find(params[:branch_office]))
                        redirect_to user_edit_path, alert: "No existe la Sucursal Seleccionada"
                    end
                    @branch_office = BranchOffice.find(params[:branch_office])
                    @user.branch_office = @branch_office
                end
                if @user.update(user_params)
                    redirect_to users_home_path, notice: "El usuario se modifico correctamente"
                else
                    redirect_to user_edit_path, alert: "Algo salio mal al modificar el usuario"
                end
            else
                redirect_to user_edit_path, alert: message
            end 
    end

    def destroy
        @user = User.find(params[:id])
        if @user.destroy
            redirect_to users_home_path , notice: "Se elimino el Usuario Correctamente"
        else
            redirect_to users_home_path , alert: "Ocurrio un error al intentar destruir el Usuario"
        end
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
            else
                message = "Ocurrio un error al modificar la contraseña"
            end
            redirect_to update_password_path(@user), notice: message
        else
            redirect_to update_password_path(@user), alert: message
        end

    end

    private

    def user_params
        params.fetch(:user ,  {}).permit(:username, :password, :role)
    end

    def validatePasswordInputs
        if !(User.find(params[:id]))
            return "No hay un usuario con esa id"
        end
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

    def validateUserInputs
        if !(params.has_key?(:authenticity_token))
            return "Estas intentando ingresar por donde no deberias"
        elsif !(params.has_key?(:user) && params[:user].has_key?(:username) && params[:user].has_key?(:password) && params[:user].has_key?(:role))
            return "Te falta Ingresar algun Dato"
        elsif (params[:user][:role] == "staff" && !(params.has_key?(:branch_office)))
            return "Falta ingresar Sucursal"
        elsif !(params[:user][:username] != "" && params[:user][:password] != "" && params[:user][:role] != "")
            return "Debe Completar todos los campos"
        elsif (params[:user][:role] == "staff" && params[:branch_office] == "")
            return "Debe completar la Sucursal"
        end
        return false
    end

end