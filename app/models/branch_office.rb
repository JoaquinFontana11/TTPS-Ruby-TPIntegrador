class BranchOffice < ApplicationRecord
  belongs_to :schedule, class_name: "Schedule"
  has_many :turn, foreign_key: true
  has_many :user, class_name: "User" , foreign_key: true

  validates :name, presence: true, uniqueness: true
  validates :direc, presence: true
  validates :tel, presence: true
  validates :schedule, presence: true, uniqueness: true
end