class BranchofficesController < ApplicationController
  $branch_office_params

  def home
    if helpers.logged_in?
      @branch_offices = BranchOffice.all
    else
      redirect_to login_path
    end
  end

  def new
    if helpers.logged_in?
      @branch_office = BranchOffice.new
    else
      redirect_to login_path
    end
  end

  def create
    if helpers.logged_in?
      message = validateBranchOfficeInputs
      puts "-----------------------"
      puts message
      puts "-----------------------"
      if !message
        $branch_office_params = params[:branchOffice]
        redirect_to schedule_new_path
      else
        redirect_to branchoffice_new_path, alert: message
      end
    else
      redirect_to login_path
    end
  end

  def new_schedule
    if helpers.logged_in?
      @schedule = Schedule.new
      render "schedules/new"
    else
      redirect_to login_path
    end
  end

  def create_schedule
    if helpers.logged_in?
      message = validateScheduleInputs
      if !message
        @schedule = Schedule.new(schedule_params)
        if @schedule.save
          params[:branchOffice] = $branch_office_params
          $branch_office_params = nil
          @branch_office = @schedule.build_branch_office(branchoffice_params)
          if @branch_office.save
            redirect_to branchoffices_home_path, notice: 'Se ha creado el producto correctamente.'
          else
            redirect_to branchoffice_new_path, alert: 'Ha ocurrido un error al crear el producto.'
          end
        else
          redirect_to schedule_new_path, alert: 'Ha ocurrido un error al crear el producto.'
        end
      else
        redirect_to schedule_new_path, alert: message
      end
    else
      redirect_to login_path
    end
  end

  def view_schedule
    @branch_office = BranchOffice.find(params[:format])
    puts "------------------------------------"
    puts @branch_office.schedule
    puts "------------------------------------"
    render "schedules/view"
  end
  
  private

  def branchoffice_params
    params.require(:branchOffice).permit(:name, :direc, :tel)
  end
  def schedule_params
    params.require(:schedule).permit(:monday, :tuesday, :wednesday, :thursday, :friday)
  end


  def validateScheduleInputs
    puts "-----------------------"
    puts params[:schedule].methods
    puts "-----------------------"
    if !(params.has_key?(:authenticity_token))
      return "Estas intentando ingresar por donde no deberias..."
    elsif !(params.has_key?(:schedule) && params[:schedule].has_key?(:monday) && params[:schedule].has_key?(:tuesday) && params[:schedule].has_key?(:wednesday) && params[:schedule].has_key?(:thursday) && params[:schedule].has_key?(:friday))
      return "Te falta Ingresar algun Dato"
    elsif !(params[:schedule][:monday] != "" && params[:schedule][:tuesday] != ""  && params[:schedule][:wednesday] != ""  && params[:schedule][:thursday] != ""  && params[:schedule][:friday] != "")
      return "Debe completar todos los campos"
  end
    return false
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
