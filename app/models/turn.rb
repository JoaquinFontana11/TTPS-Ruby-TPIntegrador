class Turn < ApplicationRecord
  belongs_to :user
  belongs_to :branch_offices

  has_many :user, :foreign_key => "turns_attended_id"
end
