class Schedule < ApplicationRecord
  has_one :branch_office, class_name: "BranchOffice"
end
