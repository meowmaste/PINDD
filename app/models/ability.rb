class Ability
	include CanCan::Ability

	def initialize(user)
		user ||= User.new #non-logged-in user
		
		if user.role == "admin"
			can :manage, :all?
		else 
			can [:read, :edit, :update, :destroy], Note, group_id: user.group_ids
			can :create, Note

			can :create, Group
			can [:read, :edit, :update, :destroy], Group, id: user.group_ids
		end
	end 
end 