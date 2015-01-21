class Beer < ActiveRecord::Base
	belongs_to :brewery
	has_many :ratings

	def average
		(ratings_per_beer = Rating.where beer_id:self.id).reduce(0) { |sum, rating| sum + rating.score } / ratings_per_beer.count
	end
end
