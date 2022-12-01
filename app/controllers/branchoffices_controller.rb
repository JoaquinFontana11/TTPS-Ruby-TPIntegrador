class BranchofficesController < ApplicationController
  def home
    @branch_offices = BranchOffice.all
  end

  def new_schedule
    puts "NEW"
    puts " -------------------------------------- "
    puts   params
    puts " -------------------------------------- "
    @schedule = Schedule.new
    render "schedules/new"
  end

  def create_schedule
    puts "POST"
    puts " -------------------------------------- "
    puts   params[:branch_office_id]
    puts " -------------------------------------- "
    @branch_office = BranchOffice.find(params[:branch_office_id])
    puts "SCHEDULE"
    puts " -------------------------------------- "
    puts   @branch_office
    puts " -------------------------------------- "
    @schedule = @branch_office.build_schedule(schedule_params)
    puts " -------------------------------------- "
    puts   @schedule.save
    puts " -------------------------------------- "
    # @schedule = Schedule.new(schedule_params)
    # if @schedule.save
    #   redirect_to branchoffice_new_path
    # else 
    #   redirect_to schedule_new_path, alert: "Algo salio mal al crear los Horarios"
    # end
    # puts " -------------------------------------- "
    # puts @branch_office.save
    # puts " -------------------------------------- "
    # if @branch_office.save
    #   redirect_to branchoffices_home_path, notice: 'Se ha creado el producto correctamente.'
    # else

    #   redirect_to branchoffice_new_path, alert: 'Ha ocurrido un error al crear el producto.'
    # end
  end

  def new
    @branch_office = BranchOffice.new
    puts "NEW"
    puts " -------------------------------------- "
    puts   params
    puts " -------------------------------------- "
  end

  def create
    @branch_office = BranchOffice.new(branchoffice_params)
    if @branch_office.save
      redirect_to schedule_new_path(@branch_office)
    else 
      redirect_to branchOffice_new_path, alert: "Algo salio mal al crear los Horarios"
    end
    # puts "CREATE"
    # puts " -------------------------------------- "
    # puts @schedule = Schedule.find(params[:branchOffice][:schedule_id])
    # puts " -------------------------------------- "
    # puts "PARAMS" 
    # puts " -------------------------------------- "
    # puts @schedule
    # puts " -------------------------------------- "
    # @branch_office = BranchOffice.new(branchoffice_params)
    # puts "SUCURSAL" 
    # puts " -------------------------------------- "
    # puts @branch_office.schedule
    # puts " -------------------------------------- "
    # # @branch_office = @schedule.branch_office.create(branchOffice_params)
    # puts " -------------------------------------- "
    # puts @branch_office.save
    # puts " -------------------------------------- "
    # if @schedule.save && @branch_office.save
    #   redirect_to branchoffices_home_path, notice: 'Se ha creado el producto correctamente.'
    # else

    #   redirect_to branchoffice_new_path, alert: 'Ha ocurrido un error al crear el producto.'
    # end
  end
  
  private

  def branchoffice_params
    params.require(:branchOffice).permit(:name, :direc, :tel)
  end
  def schedule_params
    params.require(:schedule).permit(:monday, :tuesday, :wednesday, :thursday, :friday)
  end
end
