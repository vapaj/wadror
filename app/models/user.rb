class User < ActiveRecord::Base
	include RatingAverage
	has_secure_password
	validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }
	validates :password, length: { minimum: 4 }
	validate :password, :has_uppercase_and_digit

	has_many :ratings, dependent: :destroy
  	has_many :beers, through: :ratings
  	has_many :memberships, dependent: :destroy
  	has_many :beer_clubs, through: :memberships

	def has_uppercase_and_digit
		unless password and password.match(/\A(?=(?:[^A-Z]*[A-Z]))(?=\D*\d)/)
			errors.add(:password, "needs to include at least one uppercase letter and one digit")
		end
	end
	def favorite_beer
		return nil if ratings.empty?   # palautetaan nil jos reittauksia ei ole
    	ratings.sort_by(&:score).last.beer
 	end

 	def favorite(category)
	    return nil if ratings.empty?
	    category_ratings = rated(category).inject([]) do |set, item|
	      set << {
	        item: item,
	        rating: rating_of(category, item) }
	    end

	    category_ratings.sort_by { |item| item[:rating] }.last[:item]
    end

	def favorite_brewery
		favorite :brewery
	end

	def favorite_style
		favorite :style
	end

    def rated(category)
    	ratings.map{ |r| r.beer.send(category) }.uniq
	end

	def rating_of(category, item)
		ratings_of_item = ratings.select do |r|
			r.beer.send(category) == item
		end
		ratings_of_item.map(&:score).sum / ratings_of_item.count
	end

	def already_belongs_to_club(beer_club_id)
		return true if memberships.detect {|m| m.beer_club_id == beer_club_id }
		return false
	end

	def is_confirmed_member_of_club(beer_club_id)
		memberships.find_by(beer_club_id:beer_club_id).confirmed
	end

	def self.most_active_users(n)
		users_and_ratings_count = User.all.sort_by { |u| -(u.ratings.count) }
		users_and_ratings_count.take(n)
	end

	def confirm_membership(beer_club_id)
		confirm_beer_club_membership = memberships.find_by beer_club_id: beer_club_id
		confirm_beer_club_membership.update_attribute(:confirmed, true)
	end
end