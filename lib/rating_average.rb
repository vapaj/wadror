module RatingAverage
	def average
		self.ratings.average(:score)
	end
end