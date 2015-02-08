require 'rails_helper'

describe "Beer" do
  let!(:user) { FactoryGirl.create :user }
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end
  it "when given a name, is saved to database" do
  	visit new_beer_path
  	fill_in('beer[name]', with:"Keskikebanderi")
  	select('IPA', from:'beer[style]')
  	select('Koff', from:'beer[brewery_id]')
  	expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)
  end
  it "when not given a name, return to new_beer_path" do
  	visit new_beer_path

  	select('IPA', from:'beer[style]')
  	select('Koff', from:'beer[brewery_id]')
    click_button "Create Beer"

    expect(page).to have_content "Beer must have a name!"
  end
end