class Ability
	include CanCan::Ability

	def initialize(user)
		
		if user.role == "admin"
			can :manage, :all?
		else user.role == "default"
			can :manage, Note, :user_id => user.id
		end 
	end 
end 