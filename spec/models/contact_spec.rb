require 'spec_helper'

describe Contact do

  before :each do
    @lead = Fabricate(:lead, :organisation => @company)
    @contact = Fabricate(:contact, :contactable => @lead)
  end

  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:email) }
    it { should embed_many(:phones) }
  end

  describe "associations" do
    it { should be_referenced_in :contactable}
  end

  describe "Validation" do
    context "when valid attributes" do
      let(:contact) { Fabricate.build(:contact, :contactable => @lead) }
      it "should be valid" do
        contact.should be_valid
      end
    end

    context "when invalid data" do
      let(:contact) { Fabricate.build(:contact, :first_name => "", :contactable => @lead) }
      it "should not be valid" do
        contact.should_not be_valid
        contact.save.should raise_error
      end
    end
  end

  describe "#full_name" do
    context "when last name is present" do
      let(:contact) { Fabricate(:contact, :contactable => @lead) }
      it "should return full_name" do
        contact.full_name.should == "#{contact.first_name} #{contact.last_name}"
      end
    end

    context "when last_name is not present" do
      let(:contact) { Fabricate(:contact, :last_name => "", :contactable => @lead) }
      it "should return first_name" do
  	    contact.full_name.should == "#{contact.first_name}"
      end
    end
  end

end
