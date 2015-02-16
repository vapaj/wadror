class User < ActiveRecord::Base
	include RatingAverage
	has_secure_password
	validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }
	validates :password, length: { minimum: 4 }
	validate :password, :has_uppercase_and_digit
	has_many :ratings, dependent: :destroy
	has_many :memberships

	def has_uppercase_and_digit
		unless password and password.match(/\A(?=(?:[^A-Z]*[A-Z]))(?=\D*\d)/)
			errors.add(:password, "needs to include at least one uppercase letter and one digit")
		end
	end
	def favorite_beer
		return nil if ratings.empty?   # palautetaan nil jos reittauksia ei ole
    	ratings.sort_by(&:score).last.beer
 	end
 	def favorite_style
 		
 	end
 	def already_belongs_to_club(beer_club_id)
 		return true if memberships.detect {|m| m.beer_club_id == beer_club_id }
 		return false
 	end
end
