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

  belongs_to :branch_office, class_name: "BranchOffice" ,optional: true
  belongs_to :turn, optional: true

  has_one :turn, :foreign_key => "patient_id"

  has_secure_password
end
