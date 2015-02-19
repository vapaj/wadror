class Beer < ActiveRecord::Base
	include RatingAverage
	validates :name, :style, presence: true
	belongs_to :brewery
	belongs_to :style
  	has_many :ratings, dependent: :destroy
  	has_many :raters, -> { uniq }, through: :ratings, source: :user
	def to_s
		"#{self.name}, #{self.brewery.name}"
	end

	def self.best_ratings(n)
		sorted_ratings_by_score = Beer.all.sort_by { |beer| -(beer.average || 0) }
		sorted_ratings_by_score.take(n)
	end
end
