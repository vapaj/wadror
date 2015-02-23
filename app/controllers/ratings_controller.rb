class RatingsController < ApplicationController
	def index
		Rating.fill_cache if Rating.cache_empty?

		@ratings = Rails.cache.read("ratings")
		@three_best_beers = Rails.cache.read("beer top 3")
		@three_best_breweries = Rails.cache.read("brewery top 3")
		@three_best_styles = Rails.cache.read("style top 3")
		@five_latest = Rails.cache.read("five latest ratings")
		@most_active_users = Rails.cache.read("most active users")
	end

	def new
    	@rating = Rating.new
    	@beers = Beer.all
	end

	def create
		@rating = Rating.new params.require(:rating).permit(:score, :beer_id)
	    if @rating.save
			current_user.ratings << @rating
			redirect_to user_path current_user
	    else
			@beers = Beer.all
			render :new
	    end
	end

	def destroy
	    rating = Rating.find(params[:id])
	    rating.delete if current_user == rating.user
	    redirect_to :back
	end
end