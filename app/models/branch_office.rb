class BranchOffice < ApplicationRecord
  has_one :schedule, class_name: "Schedule"
  has_many :turn, foreign_key: true
  has_many :user, foreign_key: true 
end