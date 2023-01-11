require "bcrypt"

class User < ApplicationRecord
  include BCrypt
  include ActiveModel::SecurePassword

  enum role: {
    admin: "admin",
    staff: "staff",
    client: "client"
  }

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  validates :branch_office, presence: true, if: :staff?
  validates :role, presence: true, inclusion: ["admin","staff","client"]

  belongs_to :branch_office, class_name: "BranchOffice" ,optional: true

  has_many :turns, :foreign_key => "client_id"
  has_many :turns, :foreign_key => "staff_attended_id"

  has_secure_password
end
