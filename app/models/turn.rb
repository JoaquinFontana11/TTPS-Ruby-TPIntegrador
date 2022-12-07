class Turn < ApplicationRecord
  belongs_to :patient, class_name: "User", :foreign_key => "patient_id"
  belongs_to :user, :foreign_key => "staff_attended_id"
  belongs_to :branch_offices
end
