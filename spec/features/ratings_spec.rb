require 'rails_helper'

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:style) { FactoryGirl.create :style, name:"IPA" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery, style:style }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery, style:style }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  def add_rating
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')
    click_button "Create Rating"
  end
  it "when given, is registered to the beer and user who is signed in" do
      expect{
        add_rating()
      }.to change{Rating.count}.from(0).to(1)

      expect(user.ratings.count).to eq(1)
      expect(beer1.ratings.count).to eq(1)
      expect(beer1.average).to eq(15.0)
    end
  describe "when given" do
    before :each do
      add_rating()
    end
    it "is registered to the beer and user who is signed in" do
      expect(user.ratings.count).to eq(1)
      expect(beer1.ratings.count).to eq(1)
      expect(beer1.average).to eq(15.0)
    end
    it "all ratings are listed" do
      visit ratings_path

      ratings = Rating.all
      beers = Beer.all
      users = User.all

      expect(page).to have_content "Number of ratings #{ratings.count}"
      ratings.each do |r|
        expect(page).to have_content "#{beers.find_by(r.beer_id).name} #{r.score} #{users.find_by(r.user_id).username}"
      end
    end
    it "are listed in users page" do
      visit user_path(user)
      expect(page).to have_content "#{beer1.name} #{user.ratings.find_by(beer_id:1).score} delete"
      expect(page).to have_css('li', count: user.ratings.count)
    end
    it "when rating deleted, it is also removed from db" do
      visit user_path(user)
      expect{
        all('a').select {|link| link.text == 'delete' }.first.click
      }.to change{Rating.count}.from(1).to(0)
    end
  end

  
end