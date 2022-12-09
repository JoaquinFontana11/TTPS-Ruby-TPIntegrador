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


end
