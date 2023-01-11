class BranchOffice < ApplicationRecord
  belongs_to :schedule, class_name: "Schedule"
  has_many :turns, :foreign_key => "branch_office_id",  dependent: :destroy
  has_many :users, class_name: "User" , :foreign_key => "branch_office_id",  dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :direc, presence: true
  validates :tel, presence: true
  validates :schedule, presence: true, uniqueness: true
end