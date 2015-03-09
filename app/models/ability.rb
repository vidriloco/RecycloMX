class Ability
  include CanCan::Ability

  def initialize(user)

    if user

      can :dashboard
      can :access, :rails_admin
      
      if user.has_role?(:superuser)
        can :manage, [User,
                      Deposit,
                      Location,
                      Offer,
                      Appointment]
      end
    end
  end
end