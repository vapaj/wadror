require 'rails_helper'

describe "Places" do

  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("espoo").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )
    
    visit places_path
    fill_in('city', with: 'espoo')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end
  it "if multiple is returned, all are shown at the page" do
  	allow(BeermappingApi).to receive(:places_in).with("espoo").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ), Place.new( name:"Pari Hiivaa", id: 2 ) ]
    )
    visit places_path
    fill_in('city', with: 'espoo')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Pari Hiivaa"
  end
  it "if none is returned, show warning text" do
  	city = 'espoo'
  	allow(BeermappingApi).to receive(:places_in).with(city).and_return(
      [ ]
    )
    visit places_path
    fill_in('city', with: city)
    click_button "Search"
    expect(page).to have_content "No locations in #{city}"
  end
end