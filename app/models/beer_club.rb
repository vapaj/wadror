class BeerClub < ActiveRecord::Base
	has_many :memberships
	has_many :members, -> { uniq }, through: :memberships, source: :user

	def to_s
		"#{self.name}"
	end

	def already_belongs_to_club(current_user)
		current_user.memberships.each do |m|
      		return true if m.beer_club_id == params['membership'][:beer_club_id].to_i
    	end
    	false
	end
end
