class Schedule < ApplicationRecord
  self.skip_time_zone_conversion_for_attributes = [:time_value]
  
  has_one :branch_office, class_name: "BranchOffice", dependent: :destroy

  validates :mondayInit, presence: true
  validates :mondayFinish, presence: true

  validates :tuesdayInit, presence: true
  validates :tuesdayFinish, presence: true

  validates :wednesdayInit, presence: true
  validates :wednesdayFinish, presence: true

  validates :thursdayInit, presence: true
  validates :thursdayFinish, presence: true

  validates :fridayInit, presence: true
  validates :fridayFinish, presence: true

  validates :saturdayInit, presence: true
  validates :saturdayFinish, presence: true

  validates :sundayInit, presence: true
  validates :sundayFinish, presence: true
end
