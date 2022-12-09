class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :home, :all
      can :manage, :all
      cannot :manage, Turn
    elsif user.client?
      can :home, Turn
      can :create, Turn
      can :read, Turn, client_id: user.id
      can :edit, Turn do |turn| 
        turn.client_id == user.id && turn.state == 0 
      end
      can :destroy, Turn do |turn| 
        turn.client_id == user.id && turn.state == 0 
      end
      cannot :attend, Turn
      cannot :attended, Turn
      cannot :manage, User
      can :home, BranchOffice
      can :read, BranchOffice
      can :read, Schedule 
    elsif user.staff?
      can :home, BranchOffice
      can :read, BranchOffice
      can :read, Schedule
      can :home, Turn
      can :read,  Turn, branch_office_id: user.branch_office_id
      can :attend, Turn, branch_office_id: user.branch_office_id
      can :attended, Turn, branch_office_id: user.branch_office_id
      can :read, User, role: "client"
    end
  end
end
