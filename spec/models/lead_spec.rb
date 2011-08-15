require "spec_helper"

describe Lead do

  it { should validate_presence_of :company_name }
  it { should validate_presence_of :source }

  #it { should reference_one :contact }

  it { should be_referenced_in :organisation }
  it { should be_referenced_in(:user).as_inverse_of(:leads) }
  it { should be_referenced_in(:assignee).of_type(User).with_foreign_key(:assigned_to)}

  let(:lead) { Fabricate(:lead, :organisation => @company) }

  before :each do
    contact = lead.create_contact( Fabricate.attributes_for(:contact))
    contact.create_address( Fabricate.attributes_for(:address))
  end

  
  describe "#name" do
  	it "should return leads full name" do
 	  lead.name.should eql "#{lead.contact.first_name} #{lead.contact.last_name}"
 	end	  	
  end

  describe "#company" do
  	it "should return company name" do
      lead.company.should eql lead.company_name
  	end
  end

  describe "#email" do
    it "should return email of lead contact" do
      lead.email.should eql lead.contact.email
    end
  end

end
