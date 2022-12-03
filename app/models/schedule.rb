class Schedule < ApplicationRecord
  self.skip_time_zone_conversion_for_attributes = [:time_value]
  
  has_one :branch_office, class_name: "BranchOffice", dependent: :destroy
end
