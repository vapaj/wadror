class Rating < ActiveRecord::Base
	belongs_to :beer
	belongs_to :user

	scope :five_latest, -> { order(created_at: :desc).take(5) }

	validates :score, numericality: { 	greater_than_or_equal_to: 1,
                                    	less_than_or_equal_to: 50,
                                    	only_integer: true }
	def to_s
		"#{beer.name} #{score}"
	end

  	def self.rating_page_cache_updater
	       Rails.cache.write("ratings", Rating.includes(:user, :beer).all, :expires_in => 10.minutes)
	       Rails.cache.write("five latest ratings", Rating.includes(:user, :beer).five_latest, :expires_in => 10.minutes)
	       Rails.cache.write("most active users", User.most_active_users(5), :expires_in => 10.minutes)
	       Rails.cache.write("beer top 3", Beer.best_ratings(3), :expires_in => 10.minutes)
	       Rails.cache.write("brewery top 3", Brewery.best_ratings(3), :expires_in => 10.minutes)
	       Rails.cache.write("style top 3", Style.best_style_ratings(3), :expires_in => 10.minutes)
  	end

  	def self.cache_empty?
  		["ratings", "five latest ratings", "most active users", "beer top 3", "brewery top 3", "style top 3"].each do |ca|
  			return true unless Rails.cache.exist? ca
  		end
  		false
  	end

  	def self.fill_cache
  		rating_page_cache_updater
  	end
end