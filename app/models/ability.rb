class Ability
  include CanCan::Ability

  def initialize(user)

    if user.admin?
      can :read, :all
      can :create, :all
      can :manage, :all
    elsif user.client?
      can :create, Turn
      can :read, Turn, patient_id: user.id
      can :edit, Turn do |turn| 
        turn.patient_id == user.id && turn.state == 0 
      end
      can :cancel, Turn, patient_id: user.id
    elsif user.staff?
      can :read, BranchOffice
      can :read,  Turn, branch_office_id: user.branch_office_id
      can :attend, Turn, branch_office_id: user.branch_office_id
      can :read, User, role: "client"
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
