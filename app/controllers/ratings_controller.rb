class RatingsController < ApplicationController
	def index
		@beers = Beer.all
		@ratings = Rating.all
		@users = User.all
		@three_best_beers = Beer.best_ratings 3
		@three_best_breweries = Brewery.best_ratings 3
		@five_latest = Rating.five_latest
		@most_active_users = User.most_active_users 3
		@three_best_styles = Style.best_style_ratings 3
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