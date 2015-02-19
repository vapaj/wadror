class Style < ActiveRecord::Base
	include RatingAverage

	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers
	def to_s
		"#{self.name}"
	end

	def self.best_style_ratings(n)
		sorted_ratings_by_score = Style.all.sort_by { |style| -(style.average || 0) }
		sorted_ratings_by_score.take(n)
	end
end
