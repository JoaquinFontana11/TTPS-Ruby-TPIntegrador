class Schedule < ApplicationRecord
  belongs_to :branch_office, class_name: "BranchOffice"
end
