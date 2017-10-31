class Ability
  include CanCan::Ability

  def initialize(user)
    # The user argument to initialize will generally be 'current_user' if you've defined it in your controller (see awesome_answers ApplicationController.)

    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.is_admin?
      can :manage, :all
    else
      can :read, :all
    end

      # cannot :manage, :all do |user|
      #   !user.is_admin?
      # end
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


    # In this rule, we're saying that the user can 'manage' = they can perform any CRUD operation on the resource Question. The user that is allowed to do this is the owner of the question, as shown by 'question.user == user'.
        #ability  #class #block  #instance
    can :crud, Question do |question|
      question.user == user 
    end

    can :manage, Answer do |answer|
      answer.user == user 
    end

    can :like, Question do |question|
      question.user != user
    end

    can :destroy, Like do |like|
      like.user == user
    end

    #enables cannot action
    # cannot :manage, Answer do |answer|
    #   answer.user != user
    # end

    ####### END #######
  end
end
