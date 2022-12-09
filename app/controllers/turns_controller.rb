class TurnsController < ApplicationController
    load_and_authorize_resource

    before_action :authenticate_user!
    def home
        if helpers.current_user.client?
            @turns = Turn.where(
              'client_id = ?',
              helpers.current_user.id
            ).group(:id)
          elsif helpers.current_user.staff?
            @turns = Turn.where(
              'branch_office_id = ?',
              helpers.current_user.branch_office
            ).group(:id)
          end
        render "turns/home"
    end

    def show
        @turn = Turn.find(params[:id])
    end

    def new
        @turn = Turn.new turn_params
        @branch_offices = BranchOffice.all
    end

    def create 
        message = validateTurnInputs
        if !message
            @turn = Turn.new(turn_params)
            if BranchOffice.find(params[:branch_office])
                @branch_office = BranchOffice.find(params[:branch_office])
                if validateHour(@branch_office.schedule)
                    @turn.branch_office = @branch_office
                    @turn.client = helpers.current_user
                    if @turn.save
                        flash[:notice] = "El turno se creo correctamente"
                        redirect_to turns_home_path and return
                    else
                        flash[:alert] = "Algo salio mal al crear el turno"
                        redirect_to turn_new_path and return
                    end
                else 
                    flash[:alert] = "En ese horario la sucursal esta cerrada"
                    redirect_to turn_new_path and return
                end
            else
                flash[:alert] = "No existe la Sucursal Seleccionada"
                redirect_to turn_new_path and return
            end
        else
            flash[:alert] = message
            redirect_to turn_new_path and return
        end
    end

    def edit
        @old_turn = Turn.find(params[:id])
        @branch_offices = BranchOffice.all
        render "turns/edit"
    end

    def update
        message = validateTurnInputs
        if !message
            if (Turn.find(params[:id]))
                @turn = Turn.find(params[:id])
                if BranchOffice.find(params[:branch_office])
                    @branch_office = BranchOffice.find(params[:branch_office])
                    if validateHour(@branch_office.schedule)
                        @turn.branch_office = @branch_office
                        if @turn.update(turn_params)
                            flash[:notice] =  "El turno se modifico correctamente"
                            redirect_to turns_home_path and return
                        else
                            flash[:alert] = "Algo salio mal al modificar el turno"
                            redirect_to turn_edit_path and return
                        end
                    else
                        flash[:alert] = "En ese horario la sucursal esta cerrada"
                        redirect_to turn_new_path and return
                    end
                else
                    flash[:alert] = "No existe la Sucursal Seleccionada"
                    redirect_to turn_new_path and return
                end
            else
                flash[:alert] = "No se econtro el turno"
                redirect_to turn_edit_path and return
            end
        else
            flash[:alert] = message
            redirect_to turn_edit_path and return
        end 
    end

    def destroy
        @turn = Turn.find(params[:id])
        if @turn.destroy
            flash[:notice] = "Se cancelo el Turno Correctamente"
            redirect_to turns_home_path and return
        else
            flash[:alert] = "Ocurrio un error al intentar cancelar el Turno"
            redirect_to turns_home_path and return
        end
    end

    def attend
        @turn = Turn.find(params[:id])
    end

    def attended
        message = validateAttendInputs
        if !message
            if Turn.find(params[:id])
                @turn = Turn.find(params[:id])
                @turn.user = helpers.current_user
                if @turn.update(turn_params)
                    flash[:notice] =  "El turno se atendio correctamente"
                    redirect_to turns_home_path and return
                else
                    flash[:alert] = "Algo salio mal al atender el turno"
                    redirect_to turn_attend_path and return
                end
            else
                flash[:alert] = "No se econtro el turno"
                redirect_to turn_attend_path and return
            end
        else
            flash[:alert] = message
            redirect_to turn_attend_path and return
        end
    end

    private

    def turn_params
        params.fetch(:turn, {}).permit(:date, :hour,:state, :reason, :comment)

    end

    def validateTurnInputs
        if !(params.has_key?(:authenticity_token))
            return "Estas intentando ingresar por donde no deberias"
        elsif !(params.has_key?(:turn) && params.has_key?(:branch_office) && params[:turn].has_key?(:date) && params[:turn].has_key?(:hour) && params[:turn].has_key?(:state) && params[:turn].has_key?(:reason))
            return "Te falta ingresar un dato"
        elsif !(params[:turn][:date] != "" && params[:turn][:hour] != "" && params[:turn][:state] != "" && params[:turn][:reason] != "" && params[:branch_office] != "")
            return "Debe Completar todos los campos"
        end
        return false
    end

    def validateHour(schedule)

        @hour = Time.parse(params[:turn][:hour]).hour
        @dayName = Date.parse(params[:turn][:date]).strftime("%A").downcase
        @initHour = schedule["#{@dayName}Init"].hour
        @finishHour = schedule["#{@dayName}Finish"].hour
        if @initHour == 00 && @finishHour == 00
            return false
        else
            return  @hour.between?(@initHour,@finishHour)
        end
    end

    def validateAttendInputs
        if !(params.has_key?(:authenticity_token))
            return "Estas intentando ingresar por donde no deberias"
        elsif !(params.has_key?(:turn) && params[:turn].has_key?(:comment) && params[:turn].has_key?(:state))
            return "Te falta ingresar un dato"
        elsif !(params[:turn][:comment] != "" && params[:turn][:state] != "")
            return "Debe Completar todos los campos"
        end
        return false
    end
end


