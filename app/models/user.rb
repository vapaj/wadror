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
 	# def calc_style_averages()
 	# 	Rating.find_each do |r|
		# 	if(bratings.has_key?(r.beer.style))
		# 		count = bratings[r.beer.style]['count'] = bratings[r.beer.style]['count'] + 1
		# 		sum = bratings[r.beer.style]['sum'] = bratings[r.beer.style]['sum'] + r.score
		# 	else
		# 		bratings[r.beer.style] = {'count' => 1, 'sum' => r.score, 'avg' => r.score }

			
		# 	end
		# end

 	# end
end
