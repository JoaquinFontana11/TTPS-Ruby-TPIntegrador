require "bcrypt"

class User < ApplicationRecord
  include BCrypt
  include ActiveModel::SecurePassword

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  belongs_to :branch_office

  has_secure_password
end
