class Turn < ApplicationRecord
  self.skip_time_zone_conversion_for_attributes = [:time_value]
  
  belongs_to :client, class_name: "User", :foreign_key => "client_id"
  belongs_to :user, optional: true, :foreign_key => "staff_attended_id"
  belongs_to :branch_office, class_name: "BranchOffice"

  validates :client, presence: true
  validates :branch_office, presence: true
  validates :date, presence: true 
  validates :hour, presence: true
  validates :state, presence: true, inclusion: [0,1]
  validates :reason, presence: true
  validates :comment, presence: true, if: -> {state == 1}
  validate :validateHour

  def validateHour
    @schedule = BranchOffice.find(branch_office_id).schedule
    if @schedule
      @hour = hour.hour
      @dayName = date.strftime("%A").downcase
      @initHour = @schedule["#{@dayName}Init"].hour
      @finishHour = @schedule["#{@dayName}Finish"].hour
      if @initHour == 00 && @finishHour == 00
        errors.add(:hour, "La Sucursal esta cerrada")
      else
        unless @hour.between?(@initHour,@finishHour)
          errors.add(:hour, " no se encuentra dentro de la franja horaria de la sucursal para el día elegido")
        end
      end
    else
      errors.add(:hour, "no existe la sucursal")
    end
  end

end
