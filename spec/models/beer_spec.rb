require 'rails_helper'

describe Beer do
	let!(:style) { FactoryGirl.create :style, name:"IPA" }

	it "is not saved without a name" do
		beer = Beer.create style_id:style.id
    	expect(beer).not_to be_valid
    	expect(Beer.count).to eq(0)
	end
	it "is not saved without a style" do
		beer = Beer.create name:"Bisse"
    	expect(beer).not_to be_valid
    	expect(Beer.count).to eq(0)
	end
	describe "with name and style defined" do
		let(:beer){ Beer.create name:"Bisse", style:style }
		it "is saved" do
	      expect(beer).to be_valid
	      expect(Beer.count).to eq(1)
	    end
	end
end
