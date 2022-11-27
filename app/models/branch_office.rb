class BranchOffice < ApplicationRecord
  belongs_to :schedule
  belongs_to :turn
end
