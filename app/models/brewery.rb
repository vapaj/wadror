class Brewery < ActiveRecord::Base
	include RatingAverage
	validates :name, presence: true
	validate :validate_year
	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

	def print_report
	    puts name
	    puts "established at year #{year}"
	    puts "number of beers #{beers.count}"
	end

	def restart
	    self.year = 2015
	    puts "changed year to #{year}"
	end

	def validate_year
		unless year.between?(1024, Time.now.year) and year.is_a? Integer
			errors.add(:year, "Something went wrong with the year")
		end
	end
end
