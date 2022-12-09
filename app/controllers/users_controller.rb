class UsersController < ApplicationController
    load_and_authorize_resource
    
    before_action :authenticate_user!

    def home
        if helpers.current_user.staff?
            @users = User.where("role = 'client'")
        else
            @users = User.all
        end
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
                @user = User.new(user_params)
                if(params[:user][:role] == "staff")
                    if (BranchOffice.find(params[:branch_office]))
                        @branch_office = BranchOffice.find(params[:branch_office])
                        @user.branch_office = @branch_office
                    else
                        flash[:alert] =  "No existe la Sucursal Seleccionada"
                        redirect_to new_user_path and return
                    end
                end
                if @user.save
                    flash[:notice] = "El usuario se creo correctamente"
                    redirect_to users_home_path and return
                else
                    flash[:alert] = "Algo salio mal al crear el usuario"
                    redirect_to new_user_path and return
                end
            else
                flash[:alert] = message
                redirect_to new_user_path and return
            end
    end

    def edit
        @old_user = User.find(params[:id])
        render "users/edit"
    end

    def update
            message = validateUserInputs
            if !message
                if (User.find(params[:id]))
                    @user = User.find(params[:id])
                    if(params[:user][:role] == "staff")
                        if (BranchOffice.find(params[:branch_office]))
                            @branch_office = BranchOffice.find(params[:branch_office])
                            @user.branch_office = @branch_office
                        else
                            flash[:alert] = "No existe la Sucursal Seleccionada"
                            redirect_to user_edit_path and return
                        end
                    end
                    if @user.update(user_params)
                        flash[:notice] = "El usuario se modifico correctamente"
                        redirect_to users_home_path and return
                    else
                        flash[:alert] =  "Algo salio mal al modificar el usuario"
                        redirect_to user_edit_path and return
                    end
                else
                    flash[:alert] =  "No se econtro el usuario"
                    redirect_to user_edit_path and return
                end
            else
                flash[:alert] = message
                redirect_to user_edit_path and return
            end 
    end

    def destroy
        @user = User.find(params[:id])
        if @user.destroy
            flash[:notice] = "Se elimino el Usuario Correctamente"
            redirect_to users_home_path and return
        else
            flash[:alert] = "Ocurrio un error al intentar destruir el Usuario"
            redirect_to users_home_path and return
        end
    end

    def updatePassword
        @user = User.find(params[:id])
        render "updatePassword"
    end

    def changePasword
        @user = User.find(params[:id])
        message = validatePasswordInputs
        if !message
            if @user.update_attribute(:password, params[:new_password])
                flash[:notice] = "La contraseña se modifico con Exito"
            else
                flash[:alert] = "Ocurrio un error al modificar la contraseña"
            end
            redirect_to update_password_path(@user) and return
        else
            flash[:alert] = message
            redirect_to update_password_path(@user) and return
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