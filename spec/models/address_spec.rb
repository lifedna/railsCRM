require 'spec_helper'

describe Address do

  it { should validate_presence_of :street1 }
  it { should validate_presence_of :city }
  it { should validate_presence_of :zipcode }
  it { should validate_presence_of :country }

  it { should be_embedded_in(:addressable) }

  let(:lead) { Fabricate(:lead, :organisation => @company) }
  let(:lead_contact) { Fabricate(:contact, :contactable => lead )}

  
  describe "Validity for Lead" do 
  	context "with valid attributes" do
      let(:address) { lead_contact.build_address(Fabricate.attributes_for(:address)) }
      it "should be valid" do
      	address.should be_valid
      	address.save.should be_true
        #expect{ address.save }.to be_true
        #change{ lead.address }.from(0).to(1)
      end   
  	end

  	context "with invalid attributes" do
  	  let(:address) { lead_contact.build_address(Fabricate.attributes_for(:address, :street1 => "")) }
  	  it "should not be valid" do
      	address.should_not be_valid
      	address.save.should raise_error
        #change{ lead.address.all.count }.from(0).to(1)
      end   
  	end
  end

  describe ".full_address" do
  	let(:address) { lead_contact.create_address(Fabricate.attributes_for(:address)) }
  	it "should return full address" do
      address.full_address.should eql "#{address.street1}, #{address.street2}, #{address.city.titleize}, #{address.zipcode}, #{address.country}"
    end
  end
  

end
