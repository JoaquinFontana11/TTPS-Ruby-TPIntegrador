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
    $branch_office_params = params[:branchOffice]
    redirect_to schedule_new_path and return
  end

  def edit
    @old_branch_office = BranchOffice.find(params[:id])
    render "branchoffices/edit"
  end

  def update
    @branch_office = BranchOffice.find(params[:id])
    if @branch_office.update(branchoffice_params)
      flash[:notice] =  "Se modifico correctamente la Sucursal"
      redirect_to branchoffices_home_path and return
    else
      @branch_office.errors.full_messages.each do |msg|
        flash[:alert] = msg.split(" ",2)[1]
      end
      redirect_to branchoffice_edit_path and return
    end
  end

  def destroy
      if BranchOffice.find(params[:format])
        Turn.where(
          'client_id = ?',
          helpers.current_user.id
        ).group(:id)
        @turns = Turn.where("state = 0 and branch_office_id = ?", params[:format])
        if @turns.size == 0
          @branch_office = BranchOffice.find(params[:format])
          @schedule = @branch_office.schedule
          if @schedule.destroy
            flash[:notice] = "Se elimino la Sucursal Correctamente"
            redirect_to branchoffices_home_path and return
          else
            @schedule.errors.full_messages.each do |msg|
              flash[:alert] = msg.split(" ",2)[1]
            end
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
    @schedule = Schedule.new(schedule_params)
    if @schedule.save
      params[:branchOffice] = $branch_office_params
      $branch_office_params = nil
      @branch_office = @schedule.build_branch_office(branchoffice_params)
      if @branch_office.save
        flash[:notice] = 'Se creo la Sucursal correctamente.'
        redirect_to branchoffices_home_path and return
      else
        @branch_office.errors.full_messages.each do |msg|
          flash[:alert] = msg.split(" ",2)[1]
        end
        redirect_to branchoffice_new_path and return
      end
    else
      @schedule.errors.full_messages.each do |msg|
        flash[:alert] = msg.split(" ",2)[1]
      end
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
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_params)
      flash[:notice] =  "Se modifico correctamente el Horario"
      redirect_to branchoffices_home_path and return
    else
       @schedule.errors.full_messages.each do |msg|
        flash[:alert] = msg.split(" ",2)[1]
      end
      edirect_to schedule_edit_path and return
    end
  end
  
  private

  def branchoffice_params
    params.require(:branchOffice).permit(:name, :direc, :tel)
  end
  def schedule_params
    params.require(:schedule).permit(:mondayInit,:mondayFinish,:tuesdayInit,:tuesdayFinish ,:wednesdayInit,:wednesdayFinish ,:thursdayInit,:thursdayFinish ,:fridayInit,:fridayFinish ,:saturdayInit,:saturdayFinish ,:sundayInit,:sundayFinish)
  end
end
