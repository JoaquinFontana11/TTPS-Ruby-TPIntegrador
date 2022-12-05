class BranchofficesController < ApplicationController
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
        redirect_to schedule_new_path
      else
        redirect_to branchoffice_new_path, alert: message
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
        redirect_to branchoffices_home_path, notice: "Se modifico correctamente la Sucursal"
      else
        redirect_to branchoffice_edit_path, alert: 'Ha ocurrido un error al modificar la sucursal'
      end
    else
      redirect_to branchoffice_edit_path, alert: message
    end
  end

  def destroy
      puts "---------------------------------------"
      puts params
      puts "---------------------------------------"
      @branch_office = BranchOffice.find(params[:format])
      @schedule = @branch_office.schedule
      if @schedule.destroy
        redirect_to branchoffices_home_path , notice: "Se elimino la Sucursal Correctamente"
      else
        redirect_to branchoffices_home_path , alert: "Ocurrio un error al intentar destruir la Sucursal"
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
            redirect_to branchoffices_home_path, notice: 'Se ha creado La Sucursal correctamente.'
          else
            redirect_to branchoffice_new_path, alert: 'Ha ocurrido un error al crear la Sucursal'
          end
        else
          redirect_to schedule_new_path, alert: 'Ha ocurrido un error al crear el Horario'
        end
      else
        redirect_to schedule_new_path, alert: message
      end
  end

  def view_schedule
      @branch_office = BranchOffice.find(params[:format])
      @schedule = @branch_office.schedule
      render "schedules/view"
  end

  def edit_schedule
      @old_schedule = Schedule.find(params[:format])
      render "schedules/edit"
  end

  def update_schedule
      message = validateScheduleInputs
      if !message
        @schedule = Schedule.find(params[:format_id])
        if @schedule.update(schedule_params)
          redirect_to branchoffices_home_path, notice: "Se ah modificado correctamente el Horario"
        else
          redirect_to schedule_edit_path, alert: 'Ha ocurrido un error al modificar el horario'
        end
      else
        redirect_to schedule_edit_path, alert: message
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
