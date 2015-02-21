class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]

  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
  end

  # GET /memberships/new
  def new
    @membership = Membership.new
    @beer_clubs = BeerClub.all
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships
  # POST /memberships.json
  def create
    @membership = Membership.new(membership_params)
    @membership.confirmed = false

    already_belongs_to_club = lambda {
      current_user.memberships.each do |m|
        return true if m.beer_club_id == params['membership'][:beer_club_id].to_i
      end
      false
    }

    if not already_belongs_to_club.call and @membership.save
      current_user.memberships << @membership
      flash[:notice] = "#{current_user.username}, you become a full member when your application is confirmed."
      redirect_to beer_club_path params['membership'][:beer_club_id].to_i
      
      # redirect_to user_path current_user
    else
      @beer_clubs = BeerClub.all
      @already_member = true
      render :new
    end
  end

  # PATCH/PUT /memberships/1
  # PATCH/PUT /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership.destroy
    beer_club_name = BeerClub.find(@membership.beer_club_id).name
    respond_to do |format|
      flash[:notice] = "Membership in #{beer_club_name} ended."
      format.html { redirect_to user_path current_user }
      format.json { head :no_content }
    end
  end

  def confirm_membership
    membership = Membership.find_by user_id:params[:id]
    membership.update_attribute :confirmed, true

    redirect_to :back, notice:"Confirmed membership of #{membership.user.username}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:beer_club_id, :user_id)
    end
end
