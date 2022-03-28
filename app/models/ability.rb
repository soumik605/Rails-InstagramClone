class Ability
  include CanCan::Ability

  def initialize(user)

    #can :read, Article, public: true            #if not logged in show only public posts

    return unless user.present?
      can [:create, :read], Post
      can [:update, :destroy], Post, user: user
      
      can [:create], Comment
      can [:update, :destroy], Comment, user: user

    return unless user.admin?
      #can :manage, Post
      can [:create, :read,  :destroy], Post   #cant edit post
      can [:create, :destroy], Comment   #cant edit comment

  end
end