class PlacesController < ApplicationController
  before_action :set_place
  def index
  end

  def show
    @this_place = @places.detect { |p| p.id == params[:id] }
  end

  def search
    session[:place_city] = params[:city] # Tallennetaan tieto sessioon
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end

  def set_place
    return unless session[:place_city]
    @places = BeermappingApi.places_in(session[:place_city])
  end
end