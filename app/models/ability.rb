class Ability
	include CanCan::Ability

	def initialize(user)
		user ||= User.new #non-logged-in user
		
		if user.role == "admin"
			can :manage, :all?
		else 
			can :manage, Note, :user_id => user.id 
			can :create, Group
		end
	end 
end 