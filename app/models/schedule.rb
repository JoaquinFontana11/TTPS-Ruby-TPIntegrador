class Schedule < ApplicationRecord
  self.skip_time_zone_conversion_for_attributes = [:time_value]
  
  has_one :branch_office, class_name: "BranchOffice", dependent: :destroy

  validates :mondayInit, presence: true, comparison: { less_than_or_equal_to: :mondayFinish, message: "La fecha de inicio del Lunes debe ser menor o igual a la de fin" }
  validates :mondayFinish, presence: true

  validates :tuesdayInit, presence: true, comparison: { less_than_or_equal_to: :tuesdayFinish, message: "La fecha de inicio del Martes debe ser menor o igual a la de fin" }
  validates :tuesdayFinish, presence: true

  validates :wednesdayInit, presence: true, comparison: { less_than_or_equal_to: :wednesdayFinish, message: "La fecha de inicio del Miercoles debe ser menor o igual a la de fin" }
  validates :wednesdayFinish, presence: true

  validates :thursdayInit, presence: true, comparison: { less_than_or_equal_to: :thursdayFinish, message: "La fecha de inicio del Jueves debe ser menor o igual a la de fin" }
  validates :thursdayFinish, presence: true

  validates :fridayInit, presence: true, comparison: { less_than_or_equal_to: :fridayFinish, message: "La fecha de inicio del Viernes debe ser menor o igual a la de fin" }
  validates :fridayFinish, presence: true

  validates :saturdayInit, presence: true, comparison: { less_than_or_equal_to: :saturdayFinish, message: "La fecha de inicio del Sabado debe ser menor o igual a la de fin" }
  validates :saturdayFinish, presence: true

  validates :sundayInit, presence: true, comparison: { less_than_or_equal_to: :sundayFinish, message: "La fecha de inicio del Domingo debe ser menor o igual a la de fin" }
  validates :sundayFinish, presence: true
end
