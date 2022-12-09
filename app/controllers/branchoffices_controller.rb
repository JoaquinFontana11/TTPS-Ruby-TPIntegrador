class BranchofficesController < ApplicationController
  load_and_authorize_resource "BranchOffice"

  $branch_office_params

  before_action :authenticate_user!

  def home
      @branch_offices = BranchOffice.all
  end

  def new
      @branch_office = BranchOffice.new
  end

  def create
      message = validateBranchOfficeInputs
      if !message
        $branch_office_params = params[:branchOffice]
        redirect_to schedule_new_path and return
      else
        flash[:alert] = message
        redirect_to branchoffice_new_path and return
      end
  end

  def edit
    @old_branch_office = BranchOffice.find(params[:id])
    render "branchoffices/edit"
  end

  def update
    message = validateBranchOfficeInputs
    if !message
      @branch_office = BranchOffice.find(params[:id])
      if @branch_office.update(branchoffice_params)
        flash[:notice] =  "Se modifico correctamente la Sucursal"
        redirect_to branchoffices_home_path and return
      else
        flash[:alert] = 'Ha ocurrido un error al modificar la sucursal'
        redirect_to branchoffice_edit_path and return
      end
    else
      flash[:alert] = message
      redirect_to branchoffice_edit_path and return
    end
  end

  def destroy
      if BranchOffice.find(params[:format])
        @turns = Turn.where(branch_office_id: params[:format])
        if @turns.size == 0
          @branch_office = BranchOffice.find(params[:format])
          @schedule = @branch_office.schedule
          if @schedule.destroy
            flash[:notice] = "Se elimino la Sucursal Correctamente"
            redirect_to branchoffices_home_path and return
          else
            flash[:alert] = "Ocurrio un error al intentar destruir la Sucursal"
            redirect_to branchoffices_home_path and return
          end
        else
          flash[:alert] = "La sucursal tiene turnos"
          redirect_to branchoffices_home_path and return
        end
      else
        flash[:alert] = "La sucursal no existe"
        redirect_to branchoffices_home_path and return
      end
  end

  def new_schedule
      @schedule = Schedule.new
      render "schedules/new"
  end

  def create_schedule
      message = validateScheduleInputs
      if !message
        @schedule = Schedule.new(schedule_params)
        if @schedule.save
          params[:branchOffice] = $branch_office_params
          $branch_office_params = nil
          @branch_office = @schedule.build_branch_office(branchoffice_params)
          if @branch_office.save
            flash[:notice] = 'Se creo la Sucursal correctamente.'
            redirect_to branchoffices_home_path and return
          else
            flash[:alert] =  'Ha ocurrido un error al crear la Sucursal'
            redirect_to branchoffice_new_path and return
          end
        else
          flash[:alert] =  'Ha ocurrido un error al crear el Horario'
          redirect_to schedule_new_path and return
        end
      else
        flash[:alert] =  message
        redirect_to schedule_new_path and return
      end
  end

  def view_schedule
      @branch_office = BranchOffice.find(params[:id])
      @schedule = @branch_office.schedule
      render "schedules/view"
  end

  def edit_schedule
      @old_schedule = Schedule.find(params[:id])
      render "schedules/edit"
  end

  def update_schedule
      message = validateScheduleInputs
      if !message
        @schedule = Schedule.find(params[:id])
        if @schedule.update(schedule_params)
          flash[:notice] =  "Se modifico correctamente el Horario"
          redirect_to branchoffices_home_path and return
        else
          flash[:alert] =  'Ha ocurrido un error al modificar el horario'
          redirect_to schedule_edit_path and return
        end
      else
        flash[:alert] = message
        redirect_to schedule_edit_path and return
      end
  end
  
  private

  def branchoffice_params
    params.require(:branchOffice).permit(:name, :direc, :tel)
  end
  def schedule_params
    params.require(:schedule).permit(:mondayInit,:mondayFinish,:tuesdayInit,:tuesdayFinish ,:wednesdayInit,:wednesdayFinish ,:thursdayInit,:thursdayFinish ,:fridayInit,:fridayFinish ,:saturdayInit,:saturdayFinish ,:sundayInit,:sundayFinish)
  end


  def validateScheduleInputs
    if !(params.has_key?(:authenticity_token))
      return "Estas intentando ingresar por donde no deberias..."

    elsif !(params.has_key?(:schedule) && params[:schedule].has_key?(:mondayInit) && params[:schedule].has_key?(:mondayFinish) && params[:schedule].has_key?(:tuesdayInit) && params[:schedule].has_key?(:tuesdayFinish) && params[:schedule].has_key?(:wednesdayInit) && params[:schedule].has_key?(:wednesdayFinish) && params[:schedule].has_key?(:thursdayInit) && params[:schedule].has_key?(:thursdayFinish) && params[:schedule].has_key?(:fridayInit) && params[:schedule].has_key?(:fridayFinish) && params[:schedule].has_key?(:saturdayInit) && params[:schedule].has_key?(:saturdayFinish) && params[:schedule].has_key?(:sundayInit) && params[:schedule].has_key?(:sundayFinish))
      return "Te falta Ingresar algun Dato"
    elsif !(params[:schedule][:mondayInit] != "" && params[:schedule][:mondayFinish] != "" && params[:schedule][:tuesdayInit] != "" && params[:schedule][:tuesdayFinish] != "" && params[:schedule][:wednesdayInit] != "" && params[:schedule][:wednesdayFinish] != "" && params[:schedule][:thursdayInit] != "" && params[:schedule][:thursdayFinish] != "" && params[:schedule][:fridayInit] != "" && params[:schedule][:fridayFinish] != "" && params[:schedule][:saturdayInit] != "" && params[:schedule][:saturdayFinish] != "" && params[:schedule][:sundayInit] != "" && params[:schedule][:sundayFinish] != "")
      return "Debe completar todos los campos"
    elsif ((params[:schedule][:mondayInit] <= params[:schedule][:mondayFinish]) && (params[:schedule][:tuesdayInit] <= params[:schedule][:tuesdayFinish]) && (params[:schedule][:wednesdayInit] <= params[:schedule][:wednesdayFinish]) && (params[:schedule][:thursdayInit] <= params[:schedule][:thursdayFinish]) && (params[:schedule][:fridayInit] <= params[:schedule][:fridayFinish]) && (params[:schedule][:saturdayInit] <= params[:schedule][:saturdayFinish]) && (params[:schedule][:sundayInit] <= params[:schedule][:sundayFinish]))
      return false
    end
    return "La hora de Fin no puede ser menor a la de Inicio"
  end

  def validateBranchOfficeInputs
    if !(params.has_key?(:authenticity_token))
      return "Estas intentando ingresar por donde no deberias..."
    elsif !(params.has_key?(:branchOffice) && params[:branchOffice].has_key?(:name) && params[:branchOffice].has_key?(:direc) && params[:branchOffice].has_key?(:tel))
      return "Te falta Ingresar algun Dato"
    elsif !(params[:branchOffice][:name] != "" && params[:branchOffice][:direc] != ""  && params[:branchOffice][:tel] != "")
      return "Debe completar todos los campos"
  end
    return false
  end

end
