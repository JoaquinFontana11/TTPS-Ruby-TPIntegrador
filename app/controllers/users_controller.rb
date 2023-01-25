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
                    @user.errors.full_messages.each do |msg|
                        flash[:alert] = msg.split(" ",2)[1]
                      end
                    redirect_to new_user_path and return
                end
    end

    def edit
        @old_user = User.find(params[:id])
        @branch_offices = BranchOffice.all
        render "users/edit"
    end

    def update
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
                    else
                        @user.branch_office = nil
                    end
                    if (@user.update_attribute(:username,params[:user][:username]) && (@user.update_attribute(:role,params[:user][:role])))
                        flash[:notice] = "El usuario se modifico correctamente"
                        redirect_to users_home_path and return
                    else
                        @user.errors.full_messages.each do |msg|
                            flash[:alert] = msg.split(" ",2)[1]
                          end
                        redirect_to user_edit_path and return
                    end
                else
                    flash[:alert] =  "No se econtro el usuario"
                    redirect_to user_edit_path and return
                end
    end

    def destroy
        @user = User.find(params[:id])
        if @user.destroy
            flash[:notice] = "Se elimino el Usuario Correctamente"
            redirect_to users_home_path and return
        else
            @user.errors.full_messages.each do |msg|
                flash[:alert] = msg.split(" ",2)[1]
              end
            redirect_to users_home_path and return
        end
    end

    def updatePassword
        @user = User.find(params[:id])
        render "updatePassword"
    end

    def changePasword
        @user = User.find(params[:id])
        message = validateNewPassword
        if !message
            if @user.update_attribute(:password, params[:new_password])
                flash[:notice] = "La contraseña se modifico con Exito"
            else
                @user.errors.full_messages.each do |msg|
                    flash[:alert] = msg.split(" ",2)[1]
                  end
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

    def password_params
        params.require(:user).permit(:username,:role)
    end

    def validateNewPassword
        if !(User.find(params[:id]))
            return "No hay un usuario con esa id"
        end
        @user = User.find(params[:id])
        if !(@user.authenticate(params[:password]))
            return "La contrasela actual es Incorrecta"
        elsif (params[:new_password] != params[:confirm_password])
            return "Las Contraseñas no Coinciden"
        elsif (params[:new_password] == params[:password])
            return "La nueva contraseña no puede ser igual a la Anterior"
        end
        return false
    end

end