class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= AdminUser.new # guest user (not logged in)
    if user.role? :super_admin
      can :manage, :all
    end
    if user.role? :mc_admin
      can :manage, :all
      cannot :manage, AdminUser
    end
    Page.descendants.each do |dpage|
      if user.role? dpage.to_admin_symbol
        dname = dpage.to_department_abbr_s
        can :manage, dpage
        can :manage, NewsReport, :department_id => Department.find_by_name(dname).id
        can :manage, Announcement, :department_id => Department.find_by_name(dname).id
        #can :manage, Announcement
        can :manage, DocumentCategory
        cannot :destroy, DocumentCategory
        can :manage, Document, :department_id => Department.find_by_name(dname).id
        can :manage, Carousel, :department_id => Department.find_by_name(dname).id
        can :manage, Teacher, :department_id => Department.find_by_name(dname).id
        can :manage, HomePageConfig, :department_id => Department.find_by_name(dname).id
      end
    end
    if user.role? :teacher
      can :update, Teacher, :id => user.teacher_id
    end
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
