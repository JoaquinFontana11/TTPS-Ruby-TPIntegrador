require "bcrypt"

class User < ApplicationRecord
  include BCrypt
  include ActiveModel::SecurePassword

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  
  belongs_to :branch_office, optional: true
  belongs_to :turn, optional: true

  has_one :turn, :foreign_key => "patient_id"

  has_secure_password
end
